defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, { :ok, "Hello, #{msg}" }
      greet() # 再起することでreceive状態になる
      # TIPS: ↑は無限ループでメモリを食い尽くさないか？
      # ANS: Elixirには末尾呼び出しの最適化があるため
      # 最終行での同一形式？での自身の呼び出しは最適化されるっぽい
      # def factorial(n), do: n * factorial(n)
      # ↑は関数にnをかけているため末尾再帰ではない
    end
  end
end
# ここからクライアント
pid = spawn(Spawn1, :greet, [])
send pid, {self(), "World!"}
receive do
  { :ok, message } ->
    IO.puts message
end
# 2回目
send pid, {self(), "Kermit!"}
receive do
  { :ok, message } ->
    IO.puts message
  # メッセージのタイムアウト設定ミリ秒
  after 500 ->
    IO.puts "The greeter has gone away"
end
