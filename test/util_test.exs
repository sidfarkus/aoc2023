defmodule UtilTest do
  use ExUnit.Case
  import Util

  describe "supersplit" do
    test "it splits things well" do
      assert(supersplit("a b c\nd e f\nh i j", ["\n", " "]) == [["a", "b", "c"], ["d", "e", "f"], ["h", "i", "j"]])
    end

    test "it does not wrap single items with extra lists" do
      assert(supersplit("a,b|c", ~w(| ,)) == [["a", "b"], "c"])
    end

    test "it trims each item of whitespace" do
      assert(supersplit(" a| b , d, |c ,", ~w(| ,)) == ["a", ["b", "d", ""], ["c", ""]])
    end

    test "it can remove empty items with trim" do
      assert(supersplit("b, d, |c ,", ~w(| ,), trim: true) == [["b", "d"], "c"])
    end
  end

  describe "neighbors" do
    test "four way adjacency" do
      g = grid 3, 3, fn(x, y) -> "#{x},#{y}" end
      n = neighbors g, 1, 1, four_way_adjacency()
      assert(n == ["0,1", "1,0", "2,1", "1,2"])
    end

    test "eight way adjacency" do
      g = grid 3, 3, fn(x, y) -> "#{x},#{y}" end
      n = neighbors g, 1, 1, eight_way_adjacency()
      assert(n == ["0,1", "0,0", "1,0", "2,0", "2,1", "2,2", "1,2", "0,2"])
    end
  end
end
