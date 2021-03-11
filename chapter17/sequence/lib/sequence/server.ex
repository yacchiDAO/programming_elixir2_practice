defmodule Sequence.Server do
   # OTPのGenServerビヘイビアをモジュールに実質的に追加している
   # すべてのコールバックをモジュールに定義しなくてもよいことを意味している
  use GenServer
  alias Sequence.Impl

  #####
  # 外部API このあたりを定義することで、使いやすいModuleになってくれる
  # def start_link(current_number) do
    # __MODULE__ = Sequence.Server
    # GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  # end
  # def next_number do
    # GenServer.call __MODULE__, :next_number
  # end
  # def increment_number(delta) do
    # GenServer.cast __MODULE__, { :increment_number, delta }
  # end

  #####
  # GenServerの実装
  # 例外、オブジェクト指向のコンストラクタのように考えられる
  def init(initial_number) do
    { :ok, initial_number }
  end

  # クライアントが渡した最初の引数の情報、クライアントのPID、サーバの状態
  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, Impl.next(current_number) }
  end
  # def handle_call({:set_number, new_number}, _from, _current_number) do
  #   { :reply, new_number, new_number }
  # end
  # def handle_call({:factors, number}, _, _) do
  #   { :reply, { :factors_of, number, factors(number) }, [] }
  # end

  # 最初の引数がタプル :increment_number -> 関数のハンドラ, delta -> 状態に追加する差分
  def handle_cast({:increment_number, delta}, current_number) do
    { :noreply, Impl.increment(current_number, delta) }
  end

  def format_status(_reason, [ _pdict, state ]) do
    [ data: [{'State', "My current state is '#{inspect state}', and I`m happy"}] ]
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

# castありのやつ
# iex(1)> { :ok, pid } = GenServer.start_link(Sequence.Server, 100)
# {:ok, #PID<0.173.0>}
# iex(2)> GenServer.call(pid, :next_number)
# 100
# iex(3)> GenServer.call(pid, :next_number)
# 101
# iex(4)> GenServer.cast(pid, {:increment_number, 200})
# :ok
# iex(5)> GenServer.call(pid, :next_number)
# 302
# iex(6)>

# debug
# iex(1)> { :ok, pid } = GenServer.start_link(Sequence.Server, 100, [debug: [:trace]])
# {:ok, #PID<0.182.0>}
# iex(2)> GenServer.call(pid, :next_number)
# *DBG* <0.182.0> got call next_number from <0.180.0>
# *DBG* <0.182.0> sent 100 to <0.180.0>, new state 101
# 100
# iex(3)> GenServer.call(pid, :next_number)
# *DBG* <0.182.0> got call next_number from <0.180.0>
# *DBG* <0.182.0> sent 101 to <0.180.0>, new state 102
# 101
# iex(4)> { :ok, pid } = GenServer.start_link(Sequence.Server, 100, [debug: [:statistics]])
# {:ok, #PID<0.186.0>}
# iex(5)> GenServer.call(pid, :next_number)
# 100
# iex(6)> GenServer.call(pid, :next_number)
# 101
# iex(7)> :sys.statistics pid, :get # Erlangのsysモジュールがシステムメッセージの世界へのインタフェースとなる
# {:ok,
#  [
#    start_time: {{2021, 3, 11}, {9, 17, 53}},
#    current_time: {{2021, 3, 11}, {9, 18, 15}},
#    reductions: 94,
#    messages_in: 2,
#    messages_out: 2
#  ]}

# あとからdebugをon/offを切り替えられる
# > :sys.trace pid, true
# > :sys.trace pid, false
# get_statusは便利
# > :sys.get_status pid
# GenServerから提供されるステータスメッセージのデフォルトのフォーマット
