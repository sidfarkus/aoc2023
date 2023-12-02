defmodule Util do
  import Enum, only: [map: 2, empty?: 1]
  import List, only: [pop_at: 2]
  import String, only: [split: 3]

  def supersplit(input, split_on, options \\ []) do
    unless empty?(split_on) do
      {pattern, rest} = pop_at(split_on, 0)
      splits = split(input, pattern, options)
      IO.puts("IN #{input} => #{inspect(splits)}")
      if length(splits) > 1 do
        map(splits, &(supersplit(String.trim(&1), rest, options)))
      else
        String.trim(List.first(splits)) |> supersplit(rest, options)
      end
    else
      String.trim(input)
    end
  end

  def debug(val, msg) do
    IO.puts(String.replace("DBG: #{msg}", "{val}", val))
    val
  end

  def grid(width, height, initial_value) when is_function(initial_value) do
    Map.new(for x <- 0..width-1, y <- 0..height-1, do: {{x, y}, initial_value.(x, y)})
  end

  def grid(width, height, initial_value)  do
    Map.new(for x <- 0..width-1, y <- 0..height-1, do: {{x, y}, initial_value})
  end

  def grid_at(grid, x, y) do
    Map.get grid, {x, y}
  end

  # left, up, right, bottom
  def four_way_adjacency, do: [{-1, 0}, {0, -1}, {1, 0}, {0, 1}]

  # left upleft, up, upright, right, botright, bot, botleft
  def eight_way_adjacency, do: [
    {-1, 0}, {-1, -1}, {0, -1}, { 1, -1},
    { 1, 0}, { 1,  1}, {0,  1}, {-1,  1}
  ]

  def neighbors(grid, x, y, adjacency) do
    Enum.map(adjacency, fn {x_off, y_off} -> grid_at(grid, x + x_off, y + y_off) end)
  end
end
