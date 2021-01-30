defmodule StringsAndBinaries6 do
  @moduledoc """
    文字列を文章(. )で区切って戦闘を大文字に、それ以外を小文字に変換
    """

    @doc """
    文章をわたすと変換されます

    ## Examples

      iex> StringsAndBinaries6.capitalize_sentences "Oh. A dog. Woof. "
      "Oh. A dog. Woof. "
  """
  def capitalize_sentences(str), do: String.split(str, ". ") |> _capitalize

  def _capitalize([]), do: ""
  def _capitalize([ _str | [] ]), do: "" # 末尾は". "でおわるため
  def _capitalize([ str | tail ]), do: String.capitalize(str) <> ". " <> _capitalize(tail)
end
