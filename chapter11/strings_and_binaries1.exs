defmodule StringsAndBinaries1 do
  def all_ascii?(str), do: Enum.all?(&(&1 >= ?\s && &1 <= ?~))
end
