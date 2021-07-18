defmodule NavigatorWeb.ProbesMoveValidator.Create do
  @moduledoc """
  Validate the request to move the probe
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Navigator.Error

  @required_params [:movements]
  @valid_movements ["GE", "GD", "M"]

  @typedoc """
  Request data definition
  """
  @type t :: %__MODULE__{
          movements: list(String.t())
        }

  embedded_schema do
    field :movements, {:array, :string}
  end

  @spec validate(map()) :: {:ok, t()} | {:error, Error.t()}
  @doc """
  Validate the request data
  """
  def validate(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_movements()
    |> apply_action(:create)
    |> handle_validate()
  end

  defp validate_movements(%Changeset{valid?: true} = changeset) do
    valid? =
      changeset
      |> get_field(:movements)
      |> Enum.all?(fn value -> value in @valid_movements end)

    if valid? do
      changeset
    else
      add_error(changeset, :movements, "Invalid movements list")
    end
  end

  defp validate_movements(changeset), do: changeset

  defp handle_validate({:ok, _} = result), do: result

  defp handle_validate({:error, changeset}) do
    {:error, Error.build_with_changeset(changeset)}
  end
end
