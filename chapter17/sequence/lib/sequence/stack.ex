# OTP-Servers-1
defmodule Sequence.Stack do
  use GenServer

  # init(start_arguments): 初期値. start_linkに渡された第二引数
  # 成功: { :ok, state }, 失敗: { :stop, reason }
  def init(stack) do
    { :ok, stack }
  end

  # pop
  # handle_call(request, from, state)
  def handle_call(:pop, _from, [ head | tail ]) do
    { :reply, head, tail }
  end

  # push
  def handle_cast({:push, item}, stack) do
    { :noreply, [ item | stack ]}
  end
end

# iex(1)> {:ok, pid} = GenServer.start_link(Sequence.Stack, [5, "cat", 9])
# {:ok, #PID<0.168.0>}
# iex(2)> GenServer.cast(pid, {:push, :dog})
# :ok
# iex(3)> GenServer.call(pid, :pop)
# :dog
# iex(4)> GenServer.call(pid, :pop)
# 5
# iex(5)> GenServer.call(pid, :pop)
# "cat"
# iex(6)> GenServer.call(pid, :pop)
# 9
# iex(7)> GenServer.call(pid, :pop)
#
# 09:24:06.430 [error] GenServer #PID<0.168.0> terminating
