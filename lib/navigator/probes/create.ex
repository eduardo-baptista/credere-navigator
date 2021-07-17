defmodule Navigator.Probes.Create do
  @moduledoc """
  Create new probe with the provided params
  """

  alias Navigator.{Error, Probe, Repo}

  @typedoc """
  Params definition to create new probe
  """
  @type params_t :: %{
          name: String.t()
        }

  @spec call(params_t()) :: {:ok, Probe.t()} | {:error, Error.t()}
  @doc """
  Create new probe and return it
  """
  def call(params) do
    params
    |> Probe.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, _probe} = result), do: result

  defp handle_insert({:error, changeset}) do
    {:error, Error.build_with_changeset(changeset)}
  end
end
