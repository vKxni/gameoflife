defmodule Gameoflife do
  @size 10
  @alive 1
  @dead 0

  def init do
    Enum.map(1..@size, fn _ ->
      Enum.map(1..@size, fn _ ->
        :rand.uniform(2)
      end)
    end)
  end

  def next_state(state) do
    Enum.map(state, fn row ->
      Enum.map(row, fn cell ->
        IO.inspect({state, row, cell})
        neighbors = get_neighbors(state, row, cell)

        case cell do
          @alive when length(neighbors) < 2 -> @dead
          @alive when length(neighbors) in [2, 3] -> @alive
          @alive when length(neighbors) > 3 -> @dead
          @dead when length(neighbors) == 3 -> @alive
          _ -> cell
        end
      end)
    end)
  end

  def get_neighbors(state, row, cell) do
    Enum.map(row - 1..row + 1, fn r ->
      Enum.map(cell - 1..cell + 1, fn c ->
        {r, c}
      end)
    end)
    |> List.flatten()
    |> Enum.filter(fn {r, c} ->
      r >= 0 and r < @size and c >= 0 and c < @size and {r, c} != {row, cell}
    end)
    |> Enum.map(fn {r, c} ->
      case get_in(state, [r, c]) do
        nil -> @dead
        value -> value
      end
    end)
  end
end
