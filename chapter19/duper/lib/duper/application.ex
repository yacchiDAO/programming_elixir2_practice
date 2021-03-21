defmodule Duper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Duper.Worker.start_link(arg)
      Duper.Results,
      { Duper.PathFinder, "." }, # タプルを使うとパラメータを渡せる
      Duper.WorkerSupervisor,
      { Duper.Gatherer, 1} ,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Duper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

# $ mix run
# だと何もかえってこない
# → mixタスクは終わるけどアプリケーションは終わってない
# $ mix run --no-halt
# → mixに終了しないように頼む
