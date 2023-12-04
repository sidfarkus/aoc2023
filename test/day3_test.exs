defmodule Day3Test do
  import Aoc.Day3
  use ExUnit.Case

  doctest Aoc.Day3

  describe "part 1" do
    test "example" do
      input = "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598.."

      assert(part1(input) == 4361)
    end

    test "real input" do
      IO.puts(part1(File.read!("input/day3")))
    end
  end

  describe "part2" do
    test "example" do
      input = "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598.."

      assert(part2(input) == 467835)
    end

    test "real input" do
      IO.puts(part2(File.read!("input/day3")))
    end
  end
end
