defmodule StringsAndBinaries7 do
  @moduledoc """
    特定のcsvをパースしてキーワードリストに変換
  """

  @doc """
  ファイルパスを渡す

  ## Examples

    iex> StringsAndBinaries7.csv_parse("./practice11/strings_and_binaries7.csv")
    [
      [id: 123, ship_to: :NC, net_amount: 100.0],
      [id: 124, ship_to: :OK, net_amount: 35.5],
      [id: 125, ship_to: :TX, net_amount: 24.0],
      [id: 126, ship_to: :TX, net_amount: 44.0],
      [id: 127, ship_to: :NC, net_amount: 25.0],
      [id: 128, ship_to: :MA, net_amount: 10.0],
      [id: 129, ship_to: :CA, net_amount: 102.0],
      [id: 130, ship_to: :NC, net_amount: 50.0]
    ]
  """
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
