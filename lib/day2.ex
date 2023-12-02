defmodule Aoc.Day2 do
  @moduledoc """
  Day 2 AoC
  """
  require Enum
  import Util

  def part1(input) do
    rgb = %{"red" => 12, "green" => 13, "blue" => 14}
    supersplit(input, ["\n", ":", ";", ",", " "], trim: true) |>
      Enum.map(fn [["Game", id], samples] ->
        if Enum.all?(samples, fn
            [q, c] when is_binary(q) and is_binary(c) -> String.to_integer(q) <= rgb[c]
            items -> Enum.all?(items, fn [q, c] -> String.to_integer(q) <= rgb[c] end)
          end) do
          String.to_integer(id)
        else
          0
        end
      end) |>
      Enum.sum()
  end

  def part2(input) do
    supersplit(input, ["\n", ":", ";", ",", " "], trim: true) |>
      Enum.map(fn [["Game", _id], samples] ->
        max_samples = Enum.reduce(samples, %{}, fn
          [q, c], acc when is_binary(q) and is_binary(c) ->
            Map.put(acc, c, max(String.to_integer(q), Map.get(acc, c, 0)))
          items, acc -> Enum.reduce(items, acc, fn [q, c], a ->
            Map.put(a, c, max(String.to_integer(q), Map.get(a, c, 0)))
          end)
        end)
        Map.values(max_samples) |> Enum.product()
      end) |>
      Enum.sum()
  end
end
