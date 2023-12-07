defmodule Day7Test do
  import Aoc.Day7
  use ExUnit.Case

  doctest Aoc.Day7

  describe "part 1" do
    test "example" do
      input = "32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483"

      assert(part1(input) == 6440)
    end

    test "real input" do
      IO.puts(part1(File.read!("input/day7")))
    end
  end

  describe "part2" do
    test "example" do
      input = "32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483"

      assert(part2(input) == 5905)
    end

    test "real input" do
      IO.puts(part2(File.read!("input/day7")))
    end
  end
end
