defmodule StringsAndBinaries7 do
  def csv_parse(file_path) do
    { :ok, str } = File.read(file_path)
    [ header_str | data_str_list ] = str |> String.trim |> String.split("\n")
    headers = parse_header(header_str)
    generate_data(data_str_list, headers)
  end

  defp convert_type([id: id, ship_to: ship_to, net_amount: net_amount]) do
    [
      id: id |> String.to_integer,
      ship_to: ship_to |> String.trim_leading(":") |> String.to_atom,
      net_amount: net_amount |> String.to_float
    ]
  end

  defp parse_header(str) do
    str
      |> String.trim
      |> String.split(",")
      |> Enum.map(&(String.to_atom(&1)))
  end

  defp generate_data([], _), do: []
  defp generate_data([ data_str | tail ], headers) do
    data = data_str
      |> String.trim
      |> String.split(",")
    [ Enum.zip(headers, data) |> convert_type | generate_data(tail, headers) ]
  end
end
