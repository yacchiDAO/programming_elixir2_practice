defmodule ListAndRecursion3 do
  @a_val Enum.at('a', 0)
  @z_val Enum.at('z', 0)

  defp single_caesar(val, n), do: rem((val + n - @a_val), @z_val) + @a_val
  def caesar([], _n), do: []
  def caesar([head | tail], n), do: [single_caesar(head, n) | caesar(tail, n)]
end
