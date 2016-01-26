defmodule Eeb do
  def version,  do: unquote(Mix.Project.config[:version])
  def elixir_version, do: unquote(System.version)
  
  @moduledoc """
  启动模块,主入口
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
    portValue = System.get_env("EEB_PORT") |> get_port
    Hex.Shell.info("eeb running in http://localhost:#{portValue}/")
    { :ok, _ } = Plug.Adapters.Cowboy.http(Server, [], [port: portValue])
  end

  def get_port(env_port) do
    case is_binary(env_port) do
      true ->
        if :error == Integer.parse(env_port) do
          Hex.Shell.warn("The system env EEB_PORT=#{env_port} is illegal, use default port.")
          4000
        else
          {port, _} = Integer.parse(env_port)
          port
        end
      false ->
        4000
    end
  end
  
end
