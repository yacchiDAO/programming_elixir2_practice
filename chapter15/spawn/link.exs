defmodule Link do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep 500
    # raise "oh no"
    exit(:boom)
  end

  def run do
    Process.flag(:trap_exit, true) # 死を処理可能な形に検知
    # spawn(Link, :sad_function, [])
    spawn_link(Link, :sad_function, []) # 子プロセスの死を検知
    # sleep 500
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happended as far as I am concerned"
    end
  end
end
Link.run
