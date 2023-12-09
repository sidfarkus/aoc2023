defmodule Day9Test do
  import Aoc.Day9
  use ExUnit.Case

  doctest Aoc.Day9

  describe "part 1" do
    test "example" do
      input = "0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45"

      assert(part1(input) == 114)
    end

    test "real input" do
      IO.puts(part1(File.read!("input/day9")))
    end
  end

  describe "part2" do
    test "example" do
      input = "0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45"

      assert(part2(input) == 2)
    end

    test "real input" do
      IO.puts(part2(File.read!("input/day9")))
    end
  end
end
