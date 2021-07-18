defmodule NavigatorWeb.ProbesView do
  use NavigatorWeb, :view

  def render("create.json", %{probe: probe}) do
    %{
      message: "Probe created!",
      probe: %{
        direction: probe.direction,
        id: probe.id,
        inserted_at: probe.inserted_at,
        name: probe.name,
        updated_at: probe.updated_at,
        x: probe.x,
        y: probe.y
      }
    }
  end
end
