defmodule Eeb.Monitor do
  @servername :monitorserver
  @totalhits :totalhits
  
  @moduledoc """
  主要用来监控是否要重新生成html文档
  """

  use GenServer

  # 下面是client部分
  def start_link do
    make_sure_monitor_boot_up()
    {:ok, Process.whereis(@servername)}
  end
  
  def make_sure_monitor_boot_up() do
    case Process.whereis(@servername) do
      nil ->
        GenServer.start_link(Eeb.Monitor, :ok, name: @servername)
      _ ->
        :true
    end
  end

  def get_total_hits do
    case GenServer.call(@servername, {:get_total_hits}) do
      {:ok, total_hits} ->
        total_hits
      _ ->
        0
    end
  end

  def hits do
    GenServer.cast(@servername, {:hits})
  end
  
  # 下面是server部分
  @doc """
  """
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:get_total_hits}, _form, infos) do
    if Map.has_key?(infos, @totalhits) do
      {:reply, Map.fetch(infos, @totalhits), infos}
    else
      {:reply, 0, infos}
    end
  end
  
  def handle_cast({:hits}, infos) do
    if Map.has_key?(infos, @totalhits) do
      infos = Map.update!(infos, @totalhits, &(&1 +1))
      {:noreply, infos}
    else
      {:noreply, Map.put(infos, @totalhits, 1)}
    end
  end

end
