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
    env_port = System.get_env("EEB_PORT")
    portValue = get_port(env_port)
    Hex.Shell.info("eeb running in http://localhost:#{portValue}/")
    { :ok, _ } = Plug.Adapters.Cowboy.http(Server, [], [port: portValue])
  end

  def get_port(env_port) do
    cond do
      is_binary(env_port) ->
        if :error == Integer.parse(env_port) do
          Hex.Shell.warn("The system env EEB_PORT=#{env_port} illegal, use default port.")
          portValue = 4000
        else
          {portValue, _} = Integer.parse(env_port)
        end
      true ->
        portValue = 4000
    end
    portValue
  end
  
end
