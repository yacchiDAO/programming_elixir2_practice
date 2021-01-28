defmodule StringsAndBinaries6 do
  def capitalize_sentences(str), do: String.split(str, ". ") |> _capitalize

  def _capitalize([]), do: ""
  def _capitalize([ _str | [] ]), do: "" # 末尾は". "でおわるため
  def _capitalize([ str | tail ]), do: String.capitalize(str) <> ". " <> _capitalize(tail)
end
