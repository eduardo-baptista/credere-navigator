defmodule NavigatorWeb.ProbesMoveControllerTest do
  @moduledoc false

  use NavigatorWeb.ConnCase, async: true

  import Navigator.Factory

  describe "create/2" do
    setup %{conn: conn} do
      %{id: probe_id} = insert(:probe)

      %{conn: conn, probe_id: probe_id}
    end

    test "when all params are valid, moves the probe", %{conn: conn, probe_id: probe_id} do
      # Arrange
      params = %{
        "movements" => ["GE", "M", "M", "GD", "M"]
      }

      # Act
      response =
        conn
        |> post(Routes.probes_move_path(conn, :create, probe_id, params))
        |> json_response(:ok)

      # Assert
      expected_response = %{
        "message" => "Probe moved!",
        "position" => %{"x" => 1, "y" => 2, "direction" => "D"}
      }

      assert expected_response == response
    end

    test "when has missing params, returns an error", %{conn: conn, probe_id: probe_id} do
      # Arrange
      params = %{}

      # Act
      response =
        conn
        |> post(Routes.probes_move_path(conn, :create, probe_id, params))
        |> json_response(:bad_request)

      # Assert
      expected_response = %{"errors" => %{"movements" => ["can't be blank"]}}
      assert expected_response == response
    end

    test "when movements send the probe to out of the range, returns an error", %{
      conn: conn,
      probe_id: probe_id
    } do
      # Arrange
      params = %{
        "movements" => ["M", "M", "M", "M", "M"]
      }

      # Act
      response =
        conn
        |> post(Routes.probes_move_path(conn, :create, probe_id, params))
        |> json_response(:bad_request)

      # Assert
      expected_response = %{"error" => "Invalid movements, out of the range"}
      assert expected_response == response
    end

    test "when has a invalid movement, returns an error", %{
      conn: conn,
      probe_id: probe_id
    } do
      # Arrange
      params = %{
        "movements" => ["M", "invalid", "GE", "M", "M"]
      }

      # Act
      response =
        conn
        |> post(Routes.probes_move_path(conn, :create, probe_id, params))
        |> json_response(:bad_request)

      # Assert
      expected_response = %{"errors" => %{"movements" => ["Invalid movements list"]}}
      assert expected_response == response
    end

    test "when not found the probe, returns an error", %{conn: conn} do
      # Arrange
      probe_id = "3e9022ec-82b6-4fd8-839d-ba6362c1631d"

      params = %{
        "movements" => ["GE", "M", "M", "GD", "M"]
      }

      # Act
      response =
        conn
        |> post(Routes.probes_move_path(conn, :create, probe_id, params))
        |> json_response(:not_found)

      # Assert
      expected_response = %{"error" => "Probe not found"}
      assert expected_response == response
    end
  end
end
