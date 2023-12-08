defmodule Day8Test do
  import Aoc.Day8
  use ExUnit.Case

  doctest Aoc.Day8

  describe "part 1" do
    test "example" do
      input = "RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)"

      assert(part1(input) == 2)
    end

    test "example 2" do
      input = "LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)"

      assert(part1(input) == 6)
    end

    test "real input" do
      IO.puts(part1(File.read!("input/day8")))
    end
  end

  describe "part2" do

    test "example" do
      input = "LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)"

      assert(part2(input) == 6)
    end

    @tag timeout: 300000
    test "real input" do
      IO.puts(part2(File.read!("input/day8")))
    end
  end
end
