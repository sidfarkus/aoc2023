defmodule Aoc.Day3 do
  @moduledoc """
  Day 3 AoC
  """
  require Enum
  import Util

  def sum_neighbors(neighbors, visited, _char) do
    Enum.reduce(neighbors, visited, fn {num, key}, acc -> Map.put(acc, {num, key}, num) end)
  end

  def solve(input, fun) do
    grid = supersplit(input, ["\n"], trim: true) |>
      Enum.with_index() |>
      Enum.map(fn {line, y} ->
        Enum.with_index(String.codepoints(line)) |>
        Enum.chunk_by(fn {char, _x} -> char =~ ~r/\d/ end) |>
        Enum.flat_map(fn [{char, x} | rest] ->
          if char =~ ~r/\d/ do
            num = String.to_integer(Enum.join([char] ++ Enum.map(rest, fn {c, _} -> c end), ""))
            Enum.map(0..length(rest), fn _ -> {num, {x, y}} end)
          else
            [{char, x}] ++ rest
          end
        end)
      end) |>
      grid_from()

    grid_reduce(grid, %{}, fn
      x, y, {char, _}, visited when is_binary(char) and char != "." ->
        Enum.filter(neighbors(grid, x, y, eight_way_adjacency()), fn
          {num, key} -> is_number(num) and not is_map_key(visited, {num, key}) end) |>
          Enum.dedup() |>
          fun.(visited, char)
      _x, _y, _, a -> a
    end) |>
      Map.values() |>
      Enum.sum()
  end

  def part1(input) do
    solve(input, &sum_neighbors/3)
  end

  def part2(input) do
    solve(input, fn
      [{n1, k1}, {n2, k2}], visited, char when char == "*" ->
        Map.put(visited, {n1, k1}, 0) |>
        Map.put({n2, k2}, n1 * n2)
      _, visited, _ -> visited
    end)
  end
end
