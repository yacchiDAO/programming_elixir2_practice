defmodule ListAndRecursion2 do
  defp large_value(a, b) when a > b, do: a
  defp large_value(a, b) when a <= b, do: b

  def max([]), do: nil
  def max([head | []]), do: head
  def max([head1, head2 | tail]), do: max([large_value(head1, head2) | tail])
end
