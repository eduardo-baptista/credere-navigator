defmodule Navigator.Probe do
  @moduledoc """
  Probes struct
  """

  use Ecto.Schema

  import Ecto.Changeset
  import Navigator.Helpers.Config, only: [get_max_dimensions: 0]

  alias Ecto.{Changeset, Enum, UUID}

  @primary_key {:id, UUID, autogenerate: true}
  @timestamps_opts [type: :utc_datetime]

  @required_params [:direction, :name, :x, :y]

  @directions [:B, :C, :D, :E]

  @typedoc """
  Probes definition
  """
  @type t :: %__MODULE__{
          direction: atom(),
          id: UUID.t(),
          inserted_at: DateTime.t(),
          name: String.t(),
          updated_at: DateTime.t(),
          x: integer(),
          y: integer()
        }

  schema "probes" do
    field :direction, Enum, values: @directions, default: :D
    field :name, :string
    field :x, :integer, default: 0
    field :y, :integer, default: 0

    timestamps()
  end

  @spec changeset(map()) :: Changeset.t()
  @spec changeset(t(), map()) :: Changeset.t()
  @doc """
  Handle cast and fields validations to create and update probes
  """
  def changeset(params) do
    handle_changeset(%__MODULE__{}, params, [:name])
  end

  def changeset(%__MODULE__{} = struct, params) do
    handle_changeset(struct, params, @required_params)
  end

  defp handle_changeset(struct, params, cast_params) do
    [x: x, y: y] = get_max_dimensions()

    struct
    |> cast(params, cast_params)
    |> validate_required(@required_params)
    |> validate_number(:x, greater_than_or_equal_to: 0, less_than_or_equal_to: x)
    |> validate_number(:y, greater_than_or_equal_to: 0, less_than_or_equal_to: y)
  end
end
