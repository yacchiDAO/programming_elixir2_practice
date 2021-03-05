defmodule Sequence.Server do
   # OTPのGenServerビヘイビアをモジュールに実質的に追加している
   # すべてのコールバックをモジュールに定義しなくてもよいことを意味している
  use GenServer

  # 例外、オブジェクト指向のコンストラクタのように考えられる
  def init(initial_number) do
    { :ok, initial_number }
  end

  # クライアントが渡した最初の引数の情報、クライアントのPID、サーバの状態
  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, current_number + 1 }
  end
end

# 手動でサーバを起動
# $ iex -S mix
# iex(1)> { :ok, pid } = GenServer.start_link(Sequence.Server, 100)
# {:ok, #PID<0.140.0>}
# iex(2)> GenServer.call(pid, :next_number)
# 100
# iex(3)> GenServer.call(pid, :next_number)
# 101
# iex(4)> GenServer.call(pid, :next_number)
# 102
