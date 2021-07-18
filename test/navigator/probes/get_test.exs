defmodule Navigator.Probes.GetTest do
  @moduledoc false

  use Navigator.DataCase, async: true

  import Navigator.Factory

  alias Navigator.{Error, Probe}
  alias Navigator.Probes.Get

  describe "by_id/1" do
    test "When the probe exists, returns the probe" do
      # Arrange
      %{id: id} = insert(:probe)

      # Act
      response = Get.by_id(id)

      # Assert
      assert {:ok,
              %Probe{
                direction: :D,
                id: ^id,
                inserted_at: _,
                name: "New Horizons",
                updated_at: _,
                x: 0,
                y: 0
              }} = response
    end

    test "When the probe does not exist, returns an error" do
      # Arrange
      id = "28bda4bb-6c90-43e6-8112-9621ad11feed"

      # Act
      response = Get.by_id(id)

      # Assert
      expected_response = {:error, %Error{content: "Probe not found", type: :not_found}}
      assert expected_response == response
    end
  end
end
