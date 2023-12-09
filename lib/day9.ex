defmodule Aoc.Day9 do
  @moduledoc "Day 9 AoC"
  require Enum
  import Util

  def next_val(list) do
    diffs = Stream.chunk_every(list, 2, 1, :discard) |> Enum.map(fn [a, b] -> b - a end)
    if Enum.all?(diffs, &(&1 == 0)) do
      List.first(list)
    else
      List.last(list) + next_val(diffs)
    end
  end

  def solve(nums) do
    nums
    |> Enum.map(&next_val/1)
    |> Enum.sum()
  end

  def part1(input) do
    supersplit(input, ["\n", " "], trim: true, try_convert_int: true) |> solve()
  end

  def part2(input) do
    supersplit(input, ["\n", " "], trim: true, try_convert_int: true)
    |> Enum.map(&Enum.reverse/1)
    |> solve()
  end
end
