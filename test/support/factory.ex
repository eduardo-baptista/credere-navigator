defmodule Navigator.Factory do
  @moduledoc """
  Factory helper to create data to test
  """

  use ExMachina.Ecto, repo: Navigator.Repo

  alias Navigator.Probe

  def probe_factory do
    %Probe{
      name: "New Horizons"
    }
  end

  def probe_create_params_factory, do: %{name: "New Horizons"}
end
