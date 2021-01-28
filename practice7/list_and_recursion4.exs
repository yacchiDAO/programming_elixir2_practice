defmodule ListAndRecursion4 do
  def span(to, to), do: [to]
  def span(from, to) when from < to, do: [from | span(from + 1, to)]
  def span(_, _), do: []
end
