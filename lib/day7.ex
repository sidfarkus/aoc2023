defmodule Aoc.Day7 do
  @moduledoc """
  Day 7 AoC
  """
  require Enum
  import Util

  def hand_power(hand) do
    case Map.values(Enum.frequencies(hand)) |> Enum.sort() do
      [5] -> 7
      [1, 4] -> 6
      [2, 3] -> 5
      [_, _, 3] -> 4
      [_, 2, 2] -> 3
      [_, _, _, 2] -> 2
      _ -> 1
    end
  end

  def best_hand(hand) do
    {non_jokers, jokers} = Enum.split_with(hand, &(&1 != "J"))
    Enum.map((if Enum.empty?(non_jokers), do: ["A"], else: non_jokers),
      fn c -> non_jokers ++ tl(Enum.map(0..length(jokers), fn _ -> c end)) end) |>
      Enum.max_by(&(hand_power(&1))) |>
      hand_power()
  end

  def solve(input, power_fn, card_power) do
    supersplit(input, ["\n", " "], trim: true) |>
      Enum.sort_by(fn [hand, _] ->
        cards = String.codepoints(hand)
        [power_fn.(cards)] ++ Enum.map(cards, fn card -> Enum.find_index(card_power, &(&1 == card)) end)
      end) |>
      Enum.with_index() |>
      Enum.map(fn {[_, rank], index} -> String.to_integer(rank) * (index + 1) end) |>
      Enum.sum()
  end

  def part1(input) do
    solve(input, &hand_power/1, String.codepoints("23456789TJQKA"))
  end

  def part2(input) do
    solve(input, &best_hand/1, String.codepoints("J23456789TQKA"))
  end
end
