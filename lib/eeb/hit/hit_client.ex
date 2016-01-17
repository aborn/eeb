defmodule Eeb.Hit.Client do
  @servername :hitserver
  @moduledoc """
  client
  """

  def start_link do
    make_sure_hit_server_started()
    {:ok, Process.whereis(:hitserver)}
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

  def hits(blog_key) do
    GenServer.cast(@servername, {:hits, blog_key})
  end

  def update_index() do
    Eeb.Index.generate_index_page()
  end
  
end

