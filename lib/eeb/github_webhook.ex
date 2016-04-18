defmodule Eeb.GithubWebhook do
  @servername :githubwebhookserver
  @web_hook_token_key :webhook_token
  
  @moduledoc """
  处理github来的webhook的http请求
  """
  use GenServer
  alias Eeb.ConfigUtils
  alias Eeb.BlogPath
  
  def start_link do
    make_sure_webhook_server_up()
    {:ok, Process.whereis(@servername)}
  end

  def make_sure_webhook_server_up() do
    case Process.whereis(@servername) do
      nil ->
        GenServer.start_link(Eeb.GithubWebhook, :ok, name: @servername)
      _ ->
        :ok
    end
  end

  def update_blog_event(token) do
    case ConfigUtils.read_key_value(@web_hook_token_key, nil) do
      ^token ->
        GenServer.cast(@servername, {:update_blog})
        Hex.Shell.info("update_blog_event hit!")
      _ ->
        Hex.Shell.info("update_blog_event missed!")
    end
  end
  
  # server 部分
  @doc """
  """
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({:update_blog}, infos) do
    # result = System.cmd(System.cwd() <> "/scripts/gitupdate.sh", [BlogPath.post_path],[])
    cwd_path = System.cwd()
    IEx.Helpers.cd(BlogPath.post_path)
    result = System.cmd("git", ["pull"], [])
    Hex.Shell.info("result: #{inspect result}")
    IEx.Helpers.cd(cwd_path)
    {:noreply, infos}
  end
end
