defmodule Parallel do
  def pmap(collection, fun) do
    # なぜ？ meとself()を分けた?? -> self()にしたらフリーズした -> spawn内では生成されたあとのプロセスがself()になる
    me = self()
    IO.inspect self()
    collection
    |> Enum.map(fn (elem) ->
        # spawnはプロセスを作って実行しろの意
        spawn_link fn -> (IO.inspect(self()); send me, { self(), fun.(elem) }) end
      end)
    |> Enum.map(fn (pid) ->
        # ^pidじゃないと順番に受け取らない
        receive do { ^pid, result } -> result end
      end)
  end
end

# when _pid
# > Parallel.pmap 1..10, (fn (n) -> :timer.sleep(:rand.uniform 1000); n * n end)
# [81, 1, 100, 9, 36, 16, 49, 64, 4, 25]

# when ^pid
# > Parallel.pmap 1..10, (fn (n) -> :timer.sleep(:rand.uniform 1000); n * n end)
# [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
