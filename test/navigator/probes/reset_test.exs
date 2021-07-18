defmodule Navigator.Probes.ResetTest do
  @moduledoc false
  use Navigator.DataCase, async: true

  import Navigator.Factory

  alias Navigator.{Error, Probe}
  alias Navigator.Probes.Reset

  describe "call/1" do
    setup do
      %{id: probe_id} = insert(:probe, %{direction: :E, x: 3, y: 4})

      %{probe_id: probe_id}
    end

    test "when the probe exists, reset the position", %{probe_id: probe_id} do
      # Act
      response = Reset.call(probe_id)

      # Assert
      assert {:ok,
              %Probe{
                direction: :D,
                x: 0,
                y: 0
              }} = response
    end

    test "when not found the probe, returns an error" do
      # Arrange
      probe_id = "82fab5df-bb85-4a29-8383-c2584187aab7"

      # Act
      response = Reset.call(probe_id)

      # Assert
      expected_response = {:error, %Error{content: "Probe not found", type: :not_found}}

      assert expected_response == response
    end
  end
end
