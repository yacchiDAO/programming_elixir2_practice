defmodule ListAndRecursion7 do
  def span(to, to), do: [to]
  def span(from, to) when from < to, do: [from | span(from + 1, to)]
  def span(_, _), do: []

  def prime?(n) do
    span(2, n - 1)
      |> Stream.map(&(rem(n, &1)))
      |> Enum.all?(&(&1 != 0))
  end
  def prime_list(2), do: [2]
  def prime_list(n) when n < 2, do: []
  def prime_list(n) do
    for x <- span(2, n), prime?(x), do: x
  end
end
