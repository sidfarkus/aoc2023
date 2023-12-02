defmodule Day1Test do
  import Aoc.Day1
  use ExUnit.Case

  doctest Aoc.Day1

  describe "part 1" do
    test "example" do
      input = "1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet"

      assert(part1(input) == 142)
    end

    test "real input" do
      IO.puts(part1(File.read!("input/day1")))
    end
  end

  describe "part2" do
    test "example" do
      input = "two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen"

      assert(part2(input) == 281)
    end

    test "real input" do
      IO.puts(part2(File.read!("input/day1")))
    end
  end
end
