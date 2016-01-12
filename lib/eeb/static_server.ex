defmodule StaticServer do
  @moduledoc """
  作为静态文件服务器
  """
  use Plug.Builder

  plug Plug.Static, at: "/", from: "/Users/aborn/github/eeb/html"
  plug :not_found

  def not_found(conn, _) do
    send_resp(conn, 404, "not found")
  end
end
