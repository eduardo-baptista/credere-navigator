defmodule Navigator.Factory do
  @moduledoc """
  Factory helper to create data to test
  """

  use ExMachina.Ecto, repo: Navigator.Repo

  def probe_create_params_factory, do: %{name: "New Horizons"}
end
