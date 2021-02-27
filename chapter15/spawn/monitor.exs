defmodule Monitor do
  # linkは双方向, monitorは双方向に監視
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep 500
    # raise "oh no"
    exit(:boom)
  end

  def run do
    res = spawn_monitor(Monitor, :sad_function, [])
    IO.puts inspect res
    # sleep 500
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happended as far as I am concerned"
    end
  end
end
Monitor.run

# $ elixir -r monitor.exs
# {#PID<0.99.0>, #Reference<0.1476501021.3656908802.196037>}
# MESSAGE RECEIVED: {:DOWN, #Reference<0.1476501021.3656908802.196037>, :process, #PID<0.99.0>, :boom}
