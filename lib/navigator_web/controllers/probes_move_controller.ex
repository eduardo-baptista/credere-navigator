defmodule NavigatorWeb.ProbesMoveController do
  use NavigatorWeb, :controller

  alias NavigatorWeb.FallbackController
  alias NavigatorWeb.ProbesMoveValidator.Create

  action_fallback FallbackController

  def create(conn, %{"id" => id} = params) do
    with {:ok, %{movements: movements}} <- Create.validate(params),
         {:ok, probe} <- Navigator.move_probe(id, movements) do
      conn
      |> put_status(:ok)
      |> render("probe_position.json", %{probe: probe})
    end
  end
end
