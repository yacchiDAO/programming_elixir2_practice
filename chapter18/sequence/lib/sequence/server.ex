defmodule Sequence.Server do
   # OTPのGenServerビヘイビアをモジュールに実質的に追加している
   # すべてのコールバックをモジュールに定義しなくてもよいことを意味している
  use GenServer

  #####
  # 外部API このあたりを定義することで、使いやすいModuleになってくれる
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end
  def next_number do
    GenServer.call __MODULE__, :next_number
  end
  def increment_number(delta) do
    GenServer.cast __MODULE__, { :increment_number, delta }
  end

  #####
  # GenServerの実装
  # 例外、オブジェクト指向のコンストラクタのように考えられる
  def init(_) do
    { :ok, Sequence.Stash.get() }
  end

  # クライアントが渡した最初の引数の情報、クライアントのPID、サーバの状態
  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, current_number + 1 }
  end

  # 最初の引数がタプル :increment_number -> 関数のハンドラ, delta -> 状態に追加する差分
  def handle_cast({:increment_number, delta}, current_number) do
    { :noreply, current_number + delta }
  end

  def format_status(_reason, [ _pdict, state ]) do
    [ data: [{'State', "My current state is '#{inspect state}', and I`m happy"}] ]
  end

  def terminate(_reason, current_number) do
    Sequence.Stash.update(current_number)
  end
end
