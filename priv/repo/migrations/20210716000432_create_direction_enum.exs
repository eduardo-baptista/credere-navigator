defmodule Navigator.Repo.Migrations.CreateDirectionEnum do
  @moduledoc """
  Create direction enum type
  """

  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE direction AS ENUM ('B', 'C', 'D', 'E')"
    down_query = "DROP TYPE direction"

    execute up_query, down_query
  end
end
