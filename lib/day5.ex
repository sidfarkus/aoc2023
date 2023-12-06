defmodule Aoc.Day5 do
  @moduledoc """
  Day 5 AoC
  """
  require ParallelStream
  require Enum
  import Util

  def solve(input, seed_fun) do
    supersplit(input, ["\n\n", "\n", " "], trim: true) |>
      then(fn [["seeds:" | s] | conversions] ->
        steps = Enum.map(conversions, fn [_ | factors] ->
          Enum.map(factors, fn n ->  Enum.map(n, &String.to_integer/1) end) |>
          Enum.map(fn [d, s, size] -> {(s..s+size-1), d - s} end)
        end)
        seed_fun.(s) |>
        ParallelStream.map(fn seed ->
          Enum.reduce(steps, seed, fn maps, acc ->
            Enum.find_value(maps, acc, fn
              {s_range, delta} when is_number(acc) -> acc in s_range && acc + delta
            end)
          end)
        end) |> Enum.min()
      end)
  end

  def part1(input) do
    solve(input, fn seeds -> Enum.map(seeds, &String.to_integer/1) end)
  end

  def part2(input) do
    solve(input, fn seeds ->
      Enum.chunk_every(seeds, 2) |>
        Stream.flat_map(fn [s, l] ->
          [start, size] = [String.to_integer(s), String.to_integer(l)]
          start..start+size-1
        end)
    end)
  end
end
