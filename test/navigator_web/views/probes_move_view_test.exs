defmodule NavigatorWeb.ProbesMoveViewTest do
  @moduledoc false

  use NavigatorWeb.ConnCase, async: true

  import Phoenix.View
  import Navigator.Factory

  alias NavigatorWeb.ProbesMoveView

  test "renders probe_position.json" do
    # Arrange
    probe = insert(:probe, %{x: 2, y: 1})

    # Act
    response = render(ProbesMoveView, "probe_position.json", probe: probe)

    # Assert
    expected_response = %{
      message: "Probe moved!",
      position: %{x: 2, y: 1, direction: :D}
    }

    assert expected_response == response
  end
end
