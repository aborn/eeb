defmodule Eeb.Hit.Client do
  @servername :hitserver
  @moduledoc """
  client
  """
  def start_link do
    make_sure_hit_server_started()
    {:ok, Process.whereis(@servername)}
  end
  
  @doc """
  确保server进程已经起来!
  """
  def make_sure_hit_server_started() do
    case Process.whereis(@servername) do
      nil ->
        case init() do
          {:error, {:already_started, _}} ->
            :true
          {:ok, _} ->
            :true
          _ ->
            :true
        end
      _ ->
        :true
    end
  end
  
  def init() do
    GenServer.start_link(Eeb.Hit.Server, :ok, name: @servername)
  end

  def get_hits(blog_key) do
    case GenServer.call(@servername, {:get_hits, blog_key}) do
      {:ok, hitNumber} ->
        hitNumber
      _->
        0
    end
  end

  @doc """
  获得博客站点总的访问次数
  """
  def get_total_hits do
    case GenServer.call(@servername, {:get_hits, :totalhits}) do
      {:ok, total_hits} ->
        total_hits
      _ ->
        0
    end
  end

  def hits(blog_key) do
    GenServer.cast(@servername, {:hits, blog_key})
  end
end

