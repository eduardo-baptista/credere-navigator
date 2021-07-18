defmodule NavigatorWeb.ProbesResetControllerTest do
  @moduledoc false

  use NavigatorWeb.ConnCase, async: true

  import Navigator.Factory

  describe "create/2" do
    setup %{conn: conn} do
      %{id: probe_id} = insert(:probe, %{direction: :E, x: 3, y: 4})

      %{conn: conn, probe_id: probe_id}
    end

    test "when the probe exists, reset the position", %{conn: conn, probe_id: probe_id} do
      # Act
      response =
        conn
        |> post(Routes.probes_reset_path(conn, :create, probe_id))
        |> json_response(:ok)

      # Assert
      expected_response = %{
        "message" => "Probe position reset!",
        "probe" => %{"direction" => "D", "x" => 0, "y" => 0}
      }

      assert expected_response == response
    end

    test "when not found the probe, returns an error", %{conn: conn} do
      # Arrange
      probe_id = "82fab5df-bb85-4a29-8383-c2584187aab7"

      # Act
      response =
        conn
        |> post(Routes.probes_reset_path(conn, :create, probe_id))
        |> json_response(:not_found)

      # Assert
      expected_response = %{"error" => "Probe not found"}
      assert expected_response == response
    end
  end
end
