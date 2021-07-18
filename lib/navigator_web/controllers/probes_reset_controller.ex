defmodule NavigatorWeb.ProbesResetController do
  use NavigatorWeb, :controller

  alias NavigatorWeb.FallbackController

  action_fallback FallbackController

  def create(conn, %{"id" => id}) do
    with {:ok, probe} <- Navigator.reset_probe_position(id) do
      conn
      |> put_status(:ok)
      |> render("reset.json", probe: probe)
    end
  end
end
