defmodule Aoc.Day6 do
  @moduledoc """
  Day 6 AoC
  """
  require Enum
  import Util

  def part1(input) do
    supersplit(input, ["\n", ":", " "], trim: true, try_convert_int: true) |>
      then(fn
        [["Time", times], ["Distance", distances]] when is_list(times) and is_list(distances) ->
          Stream.zip(times, distances)
        [["Time", time], ["Distance", distance]] ->
          [{time, distance}]
      end) |>
      Stream.map(fn {time, distance} ->
        Enum.reduce(1..time, 0, fn button, acc ->
          if (time - button) * button > distance, do: acc + 1, else: acc
        end)
      end) |>
      Enum.product()
  end

  def part2(input) do
    part1(String.replace(input, ~r/ */, ""))
  end
end
