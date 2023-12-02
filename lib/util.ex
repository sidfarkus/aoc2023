defmodule Util do
  import Enum, only: [map: 2, empty?: 1]
  import List, only: [pop_at: 2]
  import String, only: [split: 3]

  def supersplit(input, split_on, options \\ []) do
    unless empty?(split_on) do
      {pattern, rest} = pop_at(split_on, 0)
      map(split(input, pattern, options), &(supersplit(&1, rest)))
    else
      input
    end
  end
end
