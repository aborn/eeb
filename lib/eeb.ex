defmodule Eeb do
  def version,  do: unquote(Mix.Project.config[:version])
  def elixir_version, do: unquote(System.version)
  
  @moduledoc """
  启动模块
  """
  use Application

  def start( _type, _args ) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run),
      worker(Eeb.Hit.Client, []),
      worker(Eeb.Monitor, []),
      worker(Eeb.GithubWebhook, [])
    ]

    opts = [strategy: :one_for_one, name: Eeb.Supervisor]
    Supervisor.start_link(children, opts)
  end
  
  def run do
    { :ok, _ } = Plug.Adapters.Cowboy.http(Server, [])
  end

end
