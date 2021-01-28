defmodule ListAndRecursion1 do
  defp map([], _func), do: []
  defp map([head | tail], func), do: [func.(head) | map(tail, func)]

  defp sum([], value), do: value
  defp sum([head | tail], value), do: sum(tail, head + value)

  def mapsum(arr, func), do: map(arr, func) |> sum(0)
end
