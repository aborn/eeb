defmodule Eeb.HitClient do
  @servername :hitserver
  @moduledoc """
  client
  """

  def init() do
    GenServer.start_link(Eeb.HitServer, :ok, name: @servername)
  end

  def get_hits(blog_key) do
    case GenServer.call(@servername, {:get_hits, blog_key}) do
      {:ok, hitNumber} ->
        hitNumber
      _->
        0
    end
  end

  def hits(blog_key) do
    GenServer.cast(@servername, {:hits, blog_key})
  end
  
end

