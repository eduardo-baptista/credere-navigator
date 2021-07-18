defmodule Navigator.Probes.Get do
  @moduledoc """
  Get probes according to the provided arguments
  """

  alias Ecto.UUID
  alias Navigator.{Error, Probe, Repo}

  @spec by_id(UUID.t()) :: {:ok, Probe.t()} | {:error, Error.t()}
  @doc """
  Get probe by id
  """
  def by_id(id) do
    case Repo.get(Probe, id) do
      nil -> {:error, Error.build_resource_not_found("Probe")}
      probe -> {:ok, probe}
    end
  end
end
