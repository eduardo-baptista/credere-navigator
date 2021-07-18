defmodule Navigator.Probes.CreateTest do
  @moduledoc false

  use Navigator.DataCase, async: true

  import Navigator.Factory

  alias Navigator.{Error, Probe}
  alias Navigator.Probes.Create

  describe "call/1" do
    test "when all params are valid, create the probe" do
      # Arrange
      params = build(:probe_create_params)

      # Act
      response = Create.call(params)

      # Assert
      assert {:ok,
              %Probe{
                direction: :D,
                id: _,
                inserted_at: _,
                name: "New Horizons",
                updated_at: _,
                x: 0,
                y: 0
              }} = response
    end

    test "when has missing params, returns an error" do
      # Arrange
      params = %{}

      # Act
      response = Create.call(params)

      # Assert
      assert {:error, %Error{type: :bad_request, content: content}} = response

      expected_errors = %{name: ["can't be blank"]}
      assert expected_errors == errors_on(content)
    end
  end
end
