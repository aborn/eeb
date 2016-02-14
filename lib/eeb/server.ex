defmodule Server do
  @moduledoc """
  简单的server
  :observer.start()
  """
  
  alias Eeb.BlogPath
  alias Eeb.Hit.Client
  alias Eeb.Log
  alias Eeb.GithubWebhook
  alias Eeb.DuoshuoRecord
  
  use Timex
  import Plug.Conn

  def init(options) do
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
        |> send_resp(200, "{info:\"finish github webhooks!\"}")
      uri == "/api/duoshuo" ->
        conn = parse(conn)
        comments = conn.params["comments"]
        like = conn.params["like"]
        blog_key = conn.params["blog_key"]
        Hex.Shell.info(" comments=#{comments}, like=#{like}, blog_key=#{blog_key}")
        DuoshuoRecord.make_sure_duoshuo_record_boot_up()
        record = %Eeb.Blog{blog_key: blog_key, like: like, comments: comments}
        DuoshuoRecord.update_record(blog_key, record)
        conn
        |> send_resp(200, "post duoshuo success!")
      true ->
        query_string = conn.query_string
        Hex.Shell.info(" query_string:" <> query_string)
        conn
        |> send_resp(200, "Hello world")
    end
  end

  def parse(conn, opts \\ []) do
    opts = Keyword.put_new(opts, :parsers, [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
    Plug.Parsers.call(conn, Plug.Parsers.init(opts))
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

  defp update_hits(blog_key) do
    if blog_key =~ ~r".html$" do
      Client.hits(blog_key)
    end
  end

end
