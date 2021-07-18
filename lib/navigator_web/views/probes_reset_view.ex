defmodule NavigatorWeb.ProbesResetView do
  use NavigatorWeb, :view

  def render("reset.json", %{probe: probe}) do
    %{
      message: "Probe position reset!",
      probe: %{
        direction: probe.direction,
        x: probe.x,
        y: probe.y
      }
    }
  end
end
