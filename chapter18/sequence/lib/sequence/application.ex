defmodule Sequence.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  # アプリケーションのスーパーバイザを生成。管理するものを指定する必要がある。
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Sequence.Worker.start_link(arg)
      # {Sequence.Worker, arg}
      { Sequence.Stash, 123 },
      { Sequence.Server, nil },
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end


# アプリケーション開始でstart関数が呼ばれる
# 子サーバモジュールのリストを生成（Sequence.Server 123の引数を渡す）
# Supervisor.start_linkを呼び、子サーバの仕様リスト渡し、オプションを設定。これに基づいてスーパーバイザプロセスを生成
# 新しく生成されたスーパーバイザプロセスはstart_link関数を、管理対象となる小サーバそれぞれに呼び出す

# サーバーが壊れたときの挙動
# :one_for_one 一つ死んだらそれを再起動。デフォルト
# :one_for_all 一つ死んだら全部停止して全部再起動
# :rest_for_one 一つ死んだら子サーバのリストに連なるサーバも停止して再起動
