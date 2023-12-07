defmodule Day8Test do
  import Aoc.Day8
  use ExUnit.Case

  doctest Aoc.Day8

  describe "part 1" do
    test "example" do
      input = ""

      assert(part1(input) == 6440)
    end

    test "real input" do
      IO.puts(part1(File.read!("input/day8")))
    end
  end

  describe "part2" do
    test "example" do
      input = ""

      assert(part2(input) == 5905)
    end

    test "real input" do
      IO.puts(part2(File.read!("input/day8")))
    end
  end
end
