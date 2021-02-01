defmodule ControlFlow3 do
  @moduledoc """
    組み込み関数は{:ok, data}という形式を返し、
    xxx!の形式だとデータが返ってくる or 例外が発生。
    xxx!は全てのメソッドには存在しない
    xxxの関数において例外処理をする ok!関数をつくる
  """

  @doc """
    ## Examples:
      iex> file = ControlFlow3.ok! File.open("./practice11/strings_and_binaries7.csv")
      #PID<0.1069.0>
      iex> file = ControlFlow3.ok! File.open("./practice11/strings_and_binaries7.cs")
      ** (RuntimeError) なんかだめだった
          practice12/control_flow3.exs:14: ControlFlow3.ok!/1

  """
  def ok!({ :ok, data }), do: data
  def ok!(_), do: raise "なんかだめだった"
end
