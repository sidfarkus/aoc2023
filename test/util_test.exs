defmodule UtilTest do
  use ExUnit.Case
  import Util

  describe "supersplit" do
    test "it splits things well" do
      assert(supersplit("a b c\nd e f\nh i j", ["\n", " "]) == [["a", "b", "c"], ["d", "e", "f"], ["h", "i", "j"]])
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
