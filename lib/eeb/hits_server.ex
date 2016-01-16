defmodule Eeb.HitServer do
  @moduledoc """
  用来记录点击次数的server
  """

  use GenServer

  @doc """
  """
  def init(:ok) do
    {:ok, %{}}
  end

  @doc """
  get_hits 根据博客key，来获取博客的访问次数
  """
  def handle_call({:get_hits, blog_key}, _form, hits) do
    cond do
      Map.has_key?(hits, blog_key) ->
        Hex.Shell.info("get exists!")
        {:reply, Map.fetch(hits, blog_key), hits}
      true ->
        Hex.Shell.info("get not exists!")
        {:reply, 0, hits}
    end
  end

  @doc """
  博客被
  """
  def handle_cast({:hits, blog_key}, hits) do
    if Map.has_key?(hits, blog_key) do
      Hex.Shell.info("update")
      Map.update!(hits, blog_key, &(&1 + 1))
      {:noreply, hits}
    else
      Hex.Shell.info("create")
      {:noreply, Map.put(hits, blog_key, 1)}
    end
  end
  
end

