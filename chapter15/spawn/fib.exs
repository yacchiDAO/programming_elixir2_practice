defmodule FibSolver do
  def fib(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :fib, n, client } ->
        send client, { :answer, n, fib_calc(n), self() }
        # 処理が終わったらschedulerにreadyを投げてreceiveにはいる
        fib(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n-1) + fib_calc(n-2)
end

defmodule Scheduler do
  # 指定された数のプロセスを生成して記録、schedule_processesを呼び出す
  # to_calculate [37, 37, ...]
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end) # ここではプロセスの起動のみ
    |> schedule_processes(to_calculate, [])
  end

  # receiveのループ関数
  # processes : fibサーバーのプロセスID
  # queue : 残り計算対象
  # results : 結果
  defp schedule_processes(processes, queue, results) do
    receive do
      # サーバーにまだキューがあるかか確認
      { :ready, pid } when length(queue) > 0 ->
        # 次に処理してほしい数を計算サーバへ贈り、キューから取り除いて再起
        [ next | tail ] = queue
        send pid, { :fib, next, self() }
        schedule_processes(processes, tail, results)
      { :ready, pid } ->
        # 空の場合はshutdownを送る
        send pid, { :shutdown }
        if length(processes) > 1 do
          # 最後のプロセスでなければプロセスのリストから消去し、別のメッセージを処理するために再起する
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          # 最後のプロセスなら蓄積した結果を並び替える
          Enum.sort(results, fn { n1, _ }, { n2, _ } -> n1 <= n2 end)
        end
      # 結果を蓄積し、次のメッセージを処理するために再起するs
      { :answer, number, result, _pid } ->
        schedule_processes(processes, queue, [ { number, result } | results ])
    end
  end
end

# クライアント
to_process = List.duplicate(37, 20) # 37を20個並べた
# プロセス数を1~10まで動かすs
Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler, :run,
    [num_processes, FibSolver, :fib, to_process]
  )
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   time (s)"
  end
  :io.format "~2B     ~.2f~n", [num_processes, time / 1000000.0]
end
