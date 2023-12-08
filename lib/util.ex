defmodule Util do
  import Enum, only: [map: 2, empty?: 1]
  import List, only: [pop_at: 2]
  import String, only: [split: 3]

  def supersplit(input, split_on, options \\ []) do
    to_trim = Keyword.get(options, :to_trim, " ")
    unless empty?(split_on) do
      {pattern, rest} = pop_at(split_on, 0)
      splits = split(input, pattern, options)
      if length(splits) > 1 do
        map(splits, &(supersplit(String.trim(&1, to_trim) |> String.trim(), rest, options)))
      else
        String.trim(List.first(splits),to_trim) |> String.trim() |> supersplit(rest, options)
      end
    else
      if (Keyword.get(options, :try_convert_int, false)) do
        String.trim(input, to_trim) |> Integer.parse() |> case do
          :error -> String.trim(input, to_trim) |> String.trim()
          {i, _} -> i
        end
      else
        String.trim(input, to_trim) |> String.trim()
      end
    end
  end
  def debug(val, msg) do
    IO.puts(String.replace("DBG: #{msg}", "{val}", inspect(val)))
    val
  end
  def grid_new(width, height, initial_value) when is_function(initial_value) do
    Map.new(for x <- 0..width-1, y <- 0..height-1, do: {{x, y}, initial_value.(x, y)})
  end

  def grid_new(width, height, initial_value)  do
    Map.new(for x <- 0..width-1, y <- 0..height-1, do: {{x, y}, initial_value})
  end

  def grid_from(list_of_lists) do
    Map.new(for x <- 0..length(List.first(list_of_lists)) - 1, y <- 0..length(list_of_lists) - 1 do
      {{x, y}, Enum.at(list_of_lists, y) |> Enum.at(x)}
    end)
  end

  def grid_at(grid, x, y) when is_map(grid) do
    Map.get grid, {x, y}
  end

  def grid_map(grid, fun) when is_map(grid) do
    Enum.map Map.keys(grid), fn {x, y} ->
      fun.(x, y, Map.get(grid, {x, y}))
    end
  end

  def grid_reduce(grid, acc, fun) do
    Enum.reduce Map.keys(grid), acc, fn {x, y}, a ->
      fun.(x, y, Map.get(grid, {x, y}), a)
    end
  end

  # left, up, right, bottom
  def four_way_adjacency, do: [{-1, 0}, {0, -1}, {1, 0}, {0, 1}]

  # left upleft, up, upright, right, botright, bot, botleft
  def eight_way_adjacency, do: [
    {-1, 0}, {-1, -1}, {0, -1}, { 1, -1},
    { 1, 0}, { 1,  1}, {0,  1}, {-1,  1}
  ]

  def neighbors(grid, x, y, adjacency, options \\ []) do
    Enum.map(adjacency, fn {x_off, y_off} ->
      val = grid_at(grid, x + x_off, y + y_off)
      if Keyword.get(options, :coords, false) do
        {x + x_off, y + y_off, val}
      else
        val
      end
    end)
  end
end
