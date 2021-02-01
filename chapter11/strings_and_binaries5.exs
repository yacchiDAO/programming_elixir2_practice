defmodule StringsAndBinaries5 do
  defp long_str([ _, length1 ], [ str2, length2 ]) when length1 < length2, do: [ str2, length2 ]
  defp long_str([ str1, length1 ], [ _ , _ ]), do: [ str1, length1 ]

  defp str_max([ str1_pair | [] ]), do: str1_pair
  defp str_max([ str1_pair, str2_pair |  [] ]), do: long_str(str1_pair, str2_pair)
  defp str_max([ str1_pair, str2_pair |  list ]), do: str_max([ long_str(str1_pair, str2_pair) | list ])

  defp centering([str, length], max) when length == max, do: str
  defp centering([str, length], max) do
    space_value = (max - length) / 2
    String.duplicate(" ", floor(space_value)) <> str <> String.duplicate(" ", ceil(space_value))
  end

  defp validate_printable(str_list), do: str_list |> Enum.each(&(String.printable?(&1)) |> not_printable_error)

  defp not_printable_error(false), do: raise "Parameter has unprintable string"
  defp not_printable_error(_), do: nil

  def center(str_list) do
    str_list |> validate_printable
    str_length_pair = str_list |> Enum.map(&([ &1, String.length(&1) ]))
    [ _, max ] = str_length_pair |> str_max
    str_length_pair |> Enum.each(&(centering(&1, max) |> IO.puts))
  end
end
