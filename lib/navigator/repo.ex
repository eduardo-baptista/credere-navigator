defmodule Navigator.Repo do
  use Ecto.Repo,
    otp_app: :navigator,
    adapter: Ecto.Adapters.Postgres
end
