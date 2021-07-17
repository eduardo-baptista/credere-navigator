defmodule Navigator.Repo.Migrations.CreateProbesTable do
  @moduledoc """
  Create probes table
  """

  use Ecto.Migration

  def change do
    create table(:probes) do
      add :direction, :direction
      add :name, :string
      add :x, :integer
      add :y, :integer

      timestamps()
    end
  end
end
