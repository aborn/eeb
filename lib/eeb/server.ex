defmodule Server do
  @moduledoc """
  简单的server
  :observer.start()
  """
  
  alias Eeb.BlogPath
  alias Eeb.Hit.Client
  alias Eeb.Log
  alias Eeb.GithubWebhook
  
  use Timex
  import Plug.Conn

  def init(options) do
    # initialize options
    Hex.Shell.info("eeb running in http://localhost:4000/")
    # System.cmd("/usr/bin/open", ["-a", "/Applications/Google Chrome.app", "http://localhost:4000/"],[])
    options
  end

  def call(conn, _opts) do
    Log.log_conn(conn)
    http_res(conn, conn.request_path)
  end

  def http_res(conn, uri) do
    cond do
      uri =~ ~r".html$|/$|.css$|.png$|.ico$|.js$" ->
        fileName = get_file_name(uri)
        update_hits(fileName)      # 更新点击数
        conn
        |> put_resp_content_type(get_content_type(conn.request_path))
        |> send_resp(200, get_html_file_content(fileName))
      uri == "/github.json" ->
        conn = fetch_query_params(conn)
        params = conn.params
        Hex.Shell.info("  params #{inspect params}")
        GithubWebhook.update_blog_event(params["token"])
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, "{info:\"Hello world!\"}")
      true ->
        query_string = conn.query_string
        Hex.Shell.info(" query_string:" <> query_string)
        conn
        |> send_resp(200, "Hello world")
    end
  end

  def get_content_type(request_path) do
    cond do
      request_path == "/" ->
        "text/html"
      request_path =~ ~r".html$|.htm$|.jsp$" ->
        "text/html"
      request_path =~ ~r".css$" ->
        "text/css"
      request_path =~ ~r".png$" ->
        "image/png"
      request_path =~ ~r".ico$" ->
        "image/x-icon"
      request_path =~ ~r".gif$" ->
        "image/gif"
      request_path =~ ~r".jpe$|.jpeg$" ->
        "image/jpeg"
      request_path =~ ~r".jpg$" ->
        "application/x-jpg"
      true ->
        "text/plain"
    end
  end

  def get_html_file_content(file) do
    file = Path.join(BlogPath.html_path, file)
    # Hex.Shell.info(file)
    case File.read(file) do
      {:ok, content} ->
        content
      {:error, _} ->
        "404 not find!"
    end
  end

  defp get_file_name(request_path) do
    cond do
      request_path == "/" ->
        "index.html"
      request_path =~ ~r".html$" ->
        String.split(request_path, "/") |> List.last() |> URI.decode
      true ->
        request_path
    end
  end

  @doc """
  对html结尾的uri更新下点击次数
  """
  defp update_hits(blog_key) do
    if blog_key =~ ~r".html$" do
      Client.hits(blog_key)
    end
  end

end
