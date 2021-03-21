defmodule Duper.WorkerSupervisor do
  use DynamicSupervisor # 任意の数のワーカを実行中につくりだせる
  @me WorkerSupervisor
  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :no_args, name: @me)
  end
  def init(:no_args) do
    DynamicSupervisor.init(strategy: :one_for_one) # one_for_oneだけ
  end
  def add_worker() do
    # childに名前をつけると同名プロセスが発生してElixirは許容できなくなる
    { :ok, _pid } = DynamicSupervisor.start_child(@me, Duper.Worker)
  end
end
