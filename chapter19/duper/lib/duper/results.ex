defmodule Duper.Results do
  use GenServer
  @me __MODULE__
  #API
  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: @me)
  end
  def add_hash_for(path, hash) do
    GenServer.cast(@me, { :add, path, hash })
  end
  def find_duplicates() do
    GenServer.call(@me, :find_dupilcates)
  end

  # サーバ
  def init(:no_args) do
     { :ok, %{} }
  end
  def handle_cast( { :add, path, hash }, results) do
    results = Map.update(results, hash, [path], fn existing -> [ path | existing ] end)
    { :noreply, results }
  end
end
