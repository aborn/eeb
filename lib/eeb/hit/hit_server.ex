defmodule Eeb.Hit.Server do
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
        Hex.Shell.info("#{inspect hits} ")
        {:reply, Map.fetch(hits, blog_key), hits}
      true ->
        Hex.Shell.info("#{inspect hits} ")
        {:reply, 0, hits}
    end
  end

  @doc """
  博文被访问了一次
  """
  def handle_cast({:hits, blog_key}, hits) do
    if Map.has_key?(hits, blog_key) do
      hits = Map.update!(hits, blog_key, &(&1 +1))
      {:noreply, hits}
    else
      {:noreply, Map.put(hits, blog_key, 1)}
    end
  end

  def handle_cast({:update_index}, hits) do
    Eeb.Index.generate_index_page()
    {:noreply, hits}
  end
  
end

