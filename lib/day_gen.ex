defmodule Mix.Tasks.DayGen do
  @shortdoc "Generates a day for the given day"

  use Mix.Task

  @day_template """
  defmodule Aoc.Day{d} do
    @moduledoc "Day {d} AoC"
    require Enum
    import Util

    def part1(input) do
      supersplit(input, ["\n"], trim: true)
    end

    def part2(input) do
      supersplit(input, ["\n"], trim: true)
    end
  end
  """

  @test_template """
  defmodule Day{d}Test do
    import Aoc.Day{d}
    use ExUnit.Case

    doctest Aoc.Day{d}

    describe "part 1" do
      test "example" do
        input = ""

        assert(part1(input) == 0)
      end

      test "real input" do
        IO.puts(part1(File.read!("input/day{d}")))
      end
    end

    describe "part2" do
      test "example" do
        input = ""

        assert(part2(input) == 0)
      end

      test "real input" do
        IO.puts(part2(File.read!("input/day{d}")))
      end
    end
  end
  """

  @impl Mix.Task
  def run([day]) do
    Mix.shell().info("Creating new day #{day}...")
    if File.exists?("lib/day#{day}.ex") do
      Mix.shell().error("Day already exists!")
      exit(-1)
    end

    File.write("lib/day#{day}.ex", String.replace(@day_template, "{d}", day))
    File.write("test/day#{day}_test.ex", String.replace(@test_template, "{d}", day))
    File.write("input/day#{day}", "")

    Mix.shell().info("Done.")
  end
end
