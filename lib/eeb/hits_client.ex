defmodule Eeb.HitClient do
  @servername :hitserver
  @moduledoc """
  client
  """

  def make_sure_hit_server_started() do
    case init() do
      {:error, {:already_started, _}} ->
        :true
      {:ok, _} ->
        :true
      _ ->
        :true
    end
  end
  
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

  def update_index() do
    GenServer.cast(@servername, {:update_index})
  end
  
end

