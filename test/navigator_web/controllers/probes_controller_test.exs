defmodule NavigatorWeb.ProbesControllerTest do
  @moduledoc false

  use NavigatorWeb.ConnCase, async: true

  import Navigator.Factory

  describe "create/2" do
    test "when all params are valid, create the probe", %{conn: conn} do
      # Arrange
      params = string_params_for(:probe_create_params)

      # Act
      response =
        conn
        |> post(Routes.probes_path(conn, :create, params))
        |> json_response(:created)

      # Assert
      assert %{
               "message" => "Probe created!",
               "probe" => %{
                 "direction" => "D",
                 "id" => _,
                 "inserted_at" => _,
                 "name" => "New Horizons",
                 "updated_at" => _,
                 "x" => 0,
                 "y" => 0
               }
             } = response
    end

    test "when has missing params, returns an error", %{conn: conn} do
      # Arrange
      params = %{}

      # Act
      response =
        conn
        |> post(Routes.probes_path(conn, :create, params))
        |> json_response(:bad_request)

      # Assert
      expected_response = %{"errors" => %{"name" => ["can't be blank"]}}
      assert expected_response == response
    end
  end
end
