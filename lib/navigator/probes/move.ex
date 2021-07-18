defmodule Navigator.Probes.Move do
  @moduledoc """
  Move the probe according to the given commands
  """

  import Navigator.Helpers.Config, only: [get_max_dimensions: 0]

  alias Ecto.UUID
  alias Navigator.{Error, Probe, Repo}

  @directions_order [:C, :D, :B, :E]

  @spec call(UUID.t(), list(String.t())) :: {:ok, Probe.t()} | {:error, Error.t()}
  @doc """
  Move the probe and save the final position
  """
  def call(id, movements) when is_list(movements) do
    case Repo.get(Probe, id) do
      nil -> {:error, Error.build_resource_not_found("Probe")}
      probe -> move_probe(probe, movements)
    end
  end

  # move the probe with the commands
  defp move_probe(%Probe{direction: direction, x: x, y: y} = probe, movements) do
    coordinates =
      Enum.reduce_while(
        movements,
        %{valid?: true, direction: direction, x: x, y: y},
        &handle_movement/2
      )

    case coordinates do
      %{valid?: true} ->
        result =
          probe
          |> Probe.changeset(coordinates)
          |> Repo.update!()

        {:ok, result}

      %{valid?: false} ->
        {:error, Error.build(:bad_request, "Invalid movements, out of the range")}
    end
  end

  # handle the command to turn left
  defp handle_movement("GE", %{direction: direction} = acc) do
    direction =
      case Enum.find_index(@directions_order, &(&1 == direction)) do
        0 -> List.last(@directions_order)
        index -> Enum.at(@directions_order, index - 1)
      end

    {:cont, %{acc | direction: direction}}
  end

  # handle the command to turn right
  defp handle_movement("GD", %{direction: direction} = acc) do
    direction =
      case Enum.find_index(@directions_order, &(&1 == direction)) do
        index when index == length(@directions_order) - 1 -> List.first(@directions_order)
        index -> Enum.at(@directions_order, index + 1)
      end

    {:cont, %{acc | direction: direction}}
  end

  # handle the command to move the probe on to the current direction
  defp handle_movement("M", %{direction: direction, x: x, y: y} = acc) do
    position =
      case direction do
        :E -> %{x: x - 1, y: y}
        :D -> %{x: x + 1, y: y}
        :C -> %{x: x, y: y + 1}
        :B -> %{x: x, y: y - 1}
      end

    acc
    |> Map.merge(position)
    |> validate_position()
  end

  # validate wheter is a valid movement
  defp validate_position(%{x: x, y: y} = acc) do
    if x in get_position_range(:x) and y in get_position_range(:y) do
      {:cont, acc}
    else
      {:halt, %{acc | valid?: false}}
    end
  end

  defp get_position_range(axis) do
    max = Keyword.get(get_max_dimensions(), axis)
    0..max
  end
end
