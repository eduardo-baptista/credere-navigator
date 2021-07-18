defmodule Navigator.Probes.MoveTest do
  @moduledoc false

  use Navigator.DataCase, async: true

  import Navigator.Factory

  alias Navigator.{Error, Probe}
  alias Navigator.Probes.Move

  describe "call/2" do
    setup do
      %{id: probe_id} = insert(:probe)

      %{probe_id: probe_id}
    end

    test "when all params are valid, moves the probe", %{probe_id: probe_id} do
      # Arrange
      movements = ["GE", "M", "M", "GD", "M"]

      # Act
      response = Move.call(probe_id, movements)

      # Assert
      assert {:ok,
              %Probe{
                direction: :D,
                id: ^probe_id,
                x: 1,
                y: 2
              }} = response
    end

    test "when turn left 5 times, updates the direction to :C", %{probe_id: probe_id} do
      # Arrange
      movements = ["GE", "GE", "GE", "GE", "GE"]

      # Act
      response = Move.call(probe_id, movements)

      # Assert
      assert {:ok,
              %Probe{
                direction: :C,
                id: ^probe_id,
                x: 0,
                y: 0
              }} = response
    end

    test "when turn right 5 times, updates the direction to :B", %{probe_id: probe_id} do
      # Arrange
      movements = ["GD", "GD", "GD", "GD", "GD"]

      # Act
      response = Move.call(probe_id, movements)

      # Assert
      assert {:ok,
              %Probe{
                direction: :B,
                id: ^probe_id,
                x: 0,
                y: 0
              }} = response
    end

    test "when moves out of the range on left, returns an error" do
      # Arrange
      %{id: probe_id} = insert(:probe, %{direction: :E})
      movements = ["M"]

      # Act
      response = Move.call(probe_id, movements)

      # Assert
      expected_response = {
        :error,
        %Error{
          content: "Invalid movements, out of the range",
          type: :bad_request
        }
      }

      assert expected_response == response
    end

    test "when moves out of the range on right, returns an error" do
      # Arrange
      %{id: probe_id} = insert(:probe, %{direction: :D, x: 4})
      movements = ["M"]

      # Act
      response = Move.call(probe_id, movements)

      # Assert
      expected_response = {
        :error,
        %Error{
          content: "Invalid movements, out of the range",
          type: :bad_request
        }
      }

      assert expected_response == response
    end

    test "when moves out of the range on top, returns an error" do
      # Arrange
      %{id: probe_id} = insert(:probe, %{direction: :C, y: 4})
      movements = ["M"]

      # Act
      response = Move.call(probe_id, movements)

      # Assert
      expected_response = {
        :error,
        %Error{
          content: "Invalid movements, out of the range",
          type: :bad_request
        }
      }

      assert expected_response == response
    end

    test "when moves out of the range on bottom, returns an error" do
      # Arrange
      %{id: probe_id} = insert(:probe, %{direction: :B})
      movements = ["M"]

      # Act
      response = Move.call(probe_id, movements)

      # Assert
      expected_response = {
        :error,
        %Error{
          content: "Invalid movements, out of the range",
          type: :bad_request
        }
      }

      assert expected_response == response
    end

    test "when not found the probe, returns an error" do
      # Arrange
      probe_id = "3e9022ec-82b6-4fd8-839d-ba6362c1631d"
      movements = ["M"]

      # Act
      response = Move.call(probe_id, movements)

      # Assert
      expected_response = {:error, %Error{content: "Probe not found", type: :not_found}}

      assert expected_response == response
    end
  end
end
