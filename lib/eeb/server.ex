defmodule Server do
  @moduledoc """
  简单的server
  :observer.start()
  """
  
  alias Eeb.BlogPath
  alias Eeb.Hit.Client
  use Timex
  import Plug.Conn

  def init(options) do
    # initialize options
    Hex.Shell.info("eeb running in http://localhost:4000/")
    # System.cmd("/usr/bin/open", ["-a", "/Applications/Google Chrome.app", "http://localhost:4000/"],[])
    options
  end

  def call(conn, _opts) do
    log(conn)
    file = get_file_name(conn.request_path)
    update_hits(file)
    # Hex.Shell.info("file:" <> file <> " request_path:" <> conn.request_path)
    conn
    |> put_resp_content_type(get_content_type(conn.request_path))
    |> send_resp(200, get_html_file_content(file))
  end

  @doc """
  对html结尾的uri更新下点击次数
  """
  def update_hits(blog_key) do
    if blog_key =~ ~r".html$" do
      Client.hits(blog_key)
    end
  end
  
  defp log(conn) do
    {:ok, timeNowStr} = Date.local |> DateFormat.format("{ISO}")
    if conn.request_path =~ ~r".html$|/$" do
      Hex.Shell.info("**** " <> timeNowStr <> " " <> conn.method <> " "<> conn.request_path)
    else
      Hex.Shell.info(" " <> conn.method <> " "<> conn.request_path)
    end
  end
  
  def get_content_type(request_path) do
    cond do
      request_path == "/" ->
        "text/html"
      request_path =~ ~r".html$" ->
        "text/html"
      request_path =~ ~r".css" ->
        "text/css"
      request_path =~ ~r".png" ->
        "image/png"
      request_path =~ ~r".ico" ->
        "image/x-icon"
      true ->
        "text/plain"
    end
  end
  
  def get_file_name(request_path) do
    cond do
      request_path == "/" ->
        "index.html"
      request_path =~ ~r".html$" ->
        String.split(request_path, "/") |> List.last() |> URI.decode
      true ->
        request_path
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
end
