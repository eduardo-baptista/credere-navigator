defmodule Navigator.Probes.Reset do
  @moduledoc """
  Reset the probe position to the initial value
  """

  alias Ecto.UUID
  alias Navigator.{Error, Probe, Repo}

  @spec call(UUID.t()) :: {:ok, Probe.t()} | {:error, Error.t()}
  @doc """
  Check if probe exists and reset the position
  """
  def call(id) do
    case Repo.get(Probe, id) do
      nil -> {:error, Error.build_resource_not_found("Probe")}
      probe -> reset_position(probe)
    end
  end

  defp reset_position(probe) do
    probe =
      probe
      |> Probe.changeset(%{direction: :D, x: 0, y: 0})
      |> Repo.update!()

    {:ok, probe}
  end
end
