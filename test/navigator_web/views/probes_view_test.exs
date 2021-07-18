defmodule NavigatorWeb.ProbesViewTest do
  @moduledoc false

  use NavigatorWeb.ConnCase, async: true

  import Phoenix.View
  import Navigator.Factory

  alias NavigatorWeb.ProbesView

  test "renders create.json" do
    # Arrange
    probe = insert(:probe)

    # Act
    response = render(ProbesView, "create.json", probe: probe)

    # Assert
    assert %{
             message: "Probe created!",
             probe: %{
               direction: :D,
               id: _,
               inserted_at: _,
               name: "New Horizons",
               updated_at: _,
               x: 0,
               y: 0
             }
           } = response
  end

  test "renders probe.json" do
    # Arrange
    probe = insert(:probe)

    # Act
    response = render(ProbesView, "probe.json", probe: probe)

    # Assert
    assert %{
             probe: %{
               direction: :D,
               id: _,
               inserted_at: _,
               name: "New Horizons",
               updated_at: _,
               x: 0,
               y: 0
             }
           } = response
  end
end
