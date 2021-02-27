defmodule Chain do
  # $ elixir -r chain.exs -e "Chain.run(400_000)"
  # 09:13:00.009 [error] Too many processes
  # デフォルで40万のプロセスの生成をサポートしていない。ため指定する必要がある
  # # elixir --erl "+P 1000000" -r chain.exs -e "Chain.run(400_000)"

  # 個々のプロセスで実行されるコード
  # もらった値をインクリメントして次のプロセスへ
  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n + 1
    end
  end

  # くそむずコード n=>プロセス数
  # それぞれのプロセスは更新した数をどこに送るか知る必要がある → 一つ前のPID
  def create_processes(n) do
    # 各プロセスを作り出す無名関数
    code_to_run = fn (_, send_to) ->
      spawn(Chain, :counter, [send_to]) # 戻り値はPID
    end

    # 初期値：self()→カレントプロセスのPID
    # lastは最後のPID
    last = Enum.reduce(1..n, self(), code_to_run)

    # ここでボール送りゲームのスタート
    send(last, 0) # 最後に作ったプロセスへ0を送りカウント開始

    receive do
      # メッセージの残骸を受け取ってしまうため単純な整数を受け取るとはっきりさせる
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    # tc -> 実行時間を計測するやつ.単位はマイクロ秒
    :timer.tc(Chain, :create_processes, [n])
    |> IO.inspect
  end
end
