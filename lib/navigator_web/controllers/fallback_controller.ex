defmodule NavigatorWeb.FallbackController do
  use NavigatorWeb, :controller

  alias Navigator.Error
  alias NavigatorWeb.ErrorView

  def call(conn, {:error, %Error{type: type, content: content}}) do
    conn
    |> put_status(type)
    |> put_view(ErrorView)
    |> render("error.json", content: content)
  end
end
