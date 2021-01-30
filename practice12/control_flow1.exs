defmodule ControlFlow1 do
  @moduledoc """
    FizzBuzzをcaseで書いたバージョン
  """

  @doc """
    ## Examples:
      iex> ControlFlow1.upto(20)
      [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14,
      "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]

      iex> ControlFlow1.upto(0)
      ** (FunctionClauseError) no function clause matching in ControlFlow1.upto/1

      The following arguments were given to ControlFlow1.upto/1:

          # 1
          0
  """
  def upto(n) when n > 0, do: 1..n |> Enum.map( &(fizz_buzz(&1, rem(&1, 3), rem(&1, 5))) )

  defp fizz_buzz(n, n_3, n_5) do
    case { n, n_3, n_5 } do
    { _, 0, 0 } ->
      "FizzBuzz"
    { _, 0, _ } ->
      "Fizz"
    { _, _, 0 } ->
      "Buzz"
    { n, _, _ } ->
      n
    end
  end
end
