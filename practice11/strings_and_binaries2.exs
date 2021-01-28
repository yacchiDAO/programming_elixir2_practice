defmodule StringsAndBinaries2 do
  def anagram?(word1, word2), do: Enum.frequencies(word1) == Enum.frequencies(word2)
  def anagram2?(word1, word2), do: Enum.sort(word1) == Enum.sort(word2)
end
