defmodule Aoc.Day8 do
  @moduledoc """
  Day 8 AoC
  """
  require Enum
  import Util

  def process_node(term, _, _, {count, cur}) when cur == term, do: {:halt, count}
  def process_node(_, adj, "L", {count, cur}), do: {:cont, {count + 1, Map.get(adj, cur) |> List.first()}}
  def process_node(_, adj, "R", {count, cur}), do: {:cont, {count + 1, Map.get(adj, cur) |> List.last()}}

  def part1(input) do
    supersplit(input, ["\n\n", "\n", "= (", ","], trim: true, to_trim: ")")
      |> then(fn [dirs, graph] ->
          adj = Map.new(graph, fn [k, v] -> {k, v} end)
          String.graphemes(dirs)
          |> Stream.cycle()
          |> Enum.reduce_while({0, "AAA"}, &process_node("ZZZ", adj, &1, &2))
        end)
  end

  def part2(input) do
    supersplit(input, ["\n\n", "\n", "= (", ","], trim: true, to_trim: ")")
      |> then(fn [dirs, graph] ->
        adj = Map.new(graph, fn [k, v] -> {k, v} end)
        starts = Map.keys(adj) |> Enum.filter(&(String.ends_with?(&1, "A"))) |> Enum.map(&({:cont, {0, &1}}))
        String.graphemes(dirs)
        |> Stream.cycle()
        |> Enum.reduce_while(starts, fn dir, state ->
          new_state = Enum.map(state, fn
            {:cont, {count, cur}} -> if String.ends_with?(cur, "Z") do
              {:halt, count}
            else
              process_node("*", adj, dir, {count, cur})
            end
            x -> x
          end)
          halt = if Enum.all?(new_state, fn {:halt, _} -> true; _ -> false end), do: :halt, else: :cont
          {halt, new_state}
        end)
        |> Enum.map(fn {_, count} -> count end)
        |> Enum.reduce(fn c, acc -> Integer.floor_div((c * acc), Integer.gcd(c, acc)) end)
      end)
  end
end
