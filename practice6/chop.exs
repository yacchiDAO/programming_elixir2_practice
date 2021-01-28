defmodule Chop do
  def guess(actual, min..max) when actual >= min and actual <= max do
    val = _ans(min, max)
    IO.puts("Is it #{val}")

    _guess(val, actual, min, max)
  end

  defp _guess(val, actual, min, _) when val > actual do
    guess(actual, min..val)
  end

  defp _guess(val, actual, _, max) when val < actual do
    guess(actual, val..max)
  end

  defp _guess(val, actual, _, _) when val == actual do
    IO.puts(val)
  end

  defp _ans(min, max) do
    div((max + min), 2)
  end
end
