defmodule NavigatorWeb.ProbesController do
  use NavigatorWeb, :controller

  alias NavigatorWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, probe} <- Navigator.create_probe(params) do
      conn
      |> put_status(:created)
      |> render("create.json", probe: probe)
    end
  end
end
