defmodule Aoc.Day4 do
  @moduledoc """
  Day 4 AoC
  """
  require Enum
  import Util

  def part1(input) do
    supersplit(input, ["\n", "|", ":", " "], trim: true) |>
      Enum.map(fn [[["Card", _id], winning], nums] ->
        (MapSet.intersection(MapSet.new(winning), MapSet.new(nums)) |> MapSet.size()) - 1
       end) |>
      Enum.reject(&(&1 < 0)) |>
      Enum.map(&(2 ** &1)) |>
      Enum.sum()
  end

  def part2(input) do
    supersplit(input, ["\n", "|", ":", " "], trim: true) |>
      Enum.reduce(%{}, fn [[["Card", id], winning], nums], acc ->
        Map.put(acc, String.to_integer(id), {MapSet.new(winning), MapSet.new(nums), 1})
      end) |>
      then(fn memo ->
        Map.keys(memo) |>
        Enum.sort() |>
        Enum.reduce(memo, fn id, acc ->
          {winning, card, copies} = Map.get(acc, id)
          wins = MapSet.intersection(winning, card) |> MapSet.size()
          if wins > 0 do
            ((id + 1)..(id + wins)) |>
              Enum.reduce(acc, fn next_card, cards ->
                Map.update!(cards, next_card, fn {w, c, num} -> {w, c, num + copies} |> debug("adding #{num} + #{copies}") end)
              end)
          else
            acc
          end
        end)
      end) |>
      Map.values() |>
      Enum.map(fn {_, _, num} -> num end) |>
      Enum.sum()
  end
end
