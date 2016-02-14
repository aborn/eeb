defmodule Eeb.DuoshuoRecord do
  @servername :duoshuorecord

  @moduledoc """
  主要用来记录多说的评论数、喜欢等数据
  """
  use GenServer

  # client part
  def start_link do
    make_sure_duoshuo_record_boot_up()
    {:ok, Process.whereis(@servername)}
  end

  def make_sure_duoshuo_record_boot_up do
    case Process.whereis(@servername) do
      nil ->
        GenServer.start_link(Eeb.DuoshuoRecord, :ok, name: @servername)
      _ ->
        :true
    end
  end

  def get_record(blog_key) do
    case GenServer.call(@servername, {:get_record, blog_key}) do
      {:ok, record} ->
        record
      _->
        nil
    end
  end

  def update_record(blog_key, record) do
    GenServer.cast(@servername, {:update_record, blog_key, record})
  end

  # server part
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:get_record, blog_key}, _from, records) do
    cond do
      Map.has_key?(records, blog_key) ->
        {:reply, Map.fetch(records, blog_key), records}
      true ->
        {:reply, %Eeb.Blog{blog_key: blog_key}, records}
    end
  end

  def handle_cast({:update_record, blog_key, record}, records) do
    if Map.has_key?(records, blog_key) do
      records = Map.update!(records, blog_key,
        fn _x ->
          record
        end)
    else
      records = Map.put(records, blog_key, record)
    end
  end
end
