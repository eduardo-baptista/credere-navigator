defmodule NavigatorWeb.ProbesMoveView do
  use NavigatorWeb, :view

  def render("probe_position.json", %{probe: %{direction: direction, x: x, y: y}}) do
    %{
      message: "Probe moved!",
      position: %{direction: direction, x: x, y: y}
    }
  end
end
