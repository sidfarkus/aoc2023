defmodule UtilTest do
  use ExUnit.Case
  import Util

  describe "supersplit" do
    test "it splits things well" do
      assert(supersplit("a b c\nd e f\nh i j", ["\n", " "]) == [["a", "b", "c"], ["d", "e", "f"], ["h", "i", "j"]])
    end
  end
end
