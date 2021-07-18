defmodule NavigatorWeb.ProbesResetViewTest do
  @moduledoc false

  use NavigatorWeb.ConnCase, async: true

  import Phoenix.View
  import Navigator.Factory

  alias NavigatorWeb.ProbesResetView

  test "renders reset.json" do
    # Arrange
    probe = insert(:probe)

    # Act
    response = render(ProbesResetView, "reset.json", probe: probe)

    # Assert
    expected_response = %{
      message: "Probe position reset!",
      probe: %{direction: :D, x: 0, y: 0}
    }

    assert expected_response == response
  end
end
