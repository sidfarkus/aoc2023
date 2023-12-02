defmodule Aoc.Day1 do
  @moduledoc """
  Day 1 AoC
  """
  require Enum
  import Util

  def part1(input) do
    supersplit(input, ["\n"], trim: true) |>
    Enum.map(fn(str) ->
      String.replace(str, ~r/[^0-9]/, "") |>
      then(fn(x) -> String.first(x) <> String.last(x) end) |>
      String.to_integer()
    end) |>
    Enum.sum()
  end

  def part2(input) do
    num_map = %{"one" => 1, "two" => 2, "three" => 3, "four" => 4,
      "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9}

    supersplit(input, ["\n"], trim: true) |>
    Enum.map(fn(str) ->
      first = String.replace(str, Map.keys(num_map), &(to_string(num_map[&1])), global: false)
      last = str |>
        String.reverse() |>
        String.replace(Map.keys(num_map) |> Enum.map(&(String.reverse(&1))), &(to_string(num_map[String.reverse(&1)])), global: false)
      [first, last] |>
        Enum.map(&(String.replace(&1, ~r"[^0-9]", ""))) |>
        then(fn([f <> rest, l <> rest]) -> f <> l end) |>
        String.to_integer()
    end) |>
    Enum.sum()
  end
end
