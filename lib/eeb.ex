defmodule Eeb do
  def version,  do: unquote(Mix.Project.config[:version])
  def elixir_version, do: unquote(System.version)
  
  @moduledoc """
  the application module, main.
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
    Eeb.Convert.convert_markdown_blogs_to_html()
    portValue = (System.get_env("BLOG_PORT") || Eeb.ConfigUtils.read_key_value(:blog_port, "4000")) |> get_port
    protocal = get_protocal()

    result = case protocal do
               :https ->
                 Plug.Adapters.Cowboy.https(Server, [], [port: portValue])
               _ ->
                 Plug.Adapters.Cowboy.http(Server, [], [port: portValue])
             end

    case result do
      {:ok, pid} ->
        running_uri = "#{protocal}://localhost:#{portValue}/"
        Hex.Shell.info("#{inspect pid} eeb running in #{running_uri}")
        case :os.type() do
          {:unix, :darwin} ->
            :ok
            # System.cmd("/usr/bin/open", ["-a", "/Applications/Google Chrome.app", "#{running_uri}"], [])
          _ ->
            :ok # do nothing
        end
      {:error, :eaddrinuse} ->
        Hex.Shell.error("failed. [port #{portValue}] address already in use")
      {:error, term} ->
        Hex.Shell.error("failed. #{inspect term}")
    end

    {:ok, self()}
  end

  defp get_port(env_port) do
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

  defp get_protocal do
    :http
  end
  
end
