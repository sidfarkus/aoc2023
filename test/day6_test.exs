defmodule Day6Test do
  import Aoc.Day6
  use ExUnit.Case

  doctest Aoc.Day6

  describe "part 1" do
    test "example" do
      input = "Time:      7  15   30
Distance:  9  40  200"

      assert(part1(input) == 288)
    end

    test "real input" do
      IO.puts(part1(File.read!("input/day6")))
    end
  end

  describe "part2" do
    test "example" do
      input = "Time:      7  15   30
Distance:  9  40  200"

      assert(part2(input) == 71503)
    end

    test "real input" do
      IO.puts(part2(File.read!("input/day6")))
    end
  end
end
