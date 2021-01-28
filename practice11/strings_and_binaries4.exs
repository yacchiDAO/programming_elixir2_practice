defmodule StringsAndBinaries4 do
  # 演算子で分ける必要がありそうなので難しい
  defp calc([ digit | tail ], value) when digit in '0123456789' do
    calc(tail, value * 10 + digit - ?0)
  end
  defp calc([ operator | tail ], value) when operator == ?+ do: calc(tail, value * 10 + head - ?0)

  def caluclate(str) do
    number(str, 0)
  end
end
