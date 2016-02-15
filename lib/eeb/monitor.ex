defmodule Eeb.Monitor do
  @servername :monitorserver
  @statusflag :statusflag
  
  @moduledoc """
  主要用来监控是否要重新生成html文档
  """

  use GenServer
  use Timex

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

  def hits_event do
    GenServer.cast(@servername, {:hits_event})
  end

  def regenerate_index do
    GenServer.cast(@servername, {:regenerate_index})
  end

  # 下面是server部分
  def init(:ok) do
    {:ok, %{}}
  end
  
  def handle_cast({:hits_event}, infos) do
    if Map.has_key?(infos, @statusflag) do
      #infos = Map.update!(infos, @statusflag, &(&1 +1))
      {:ok, lastTimeSec} = Map.fetch(infos, @statusflag)
      currentTimeSec = Time.now(:secs)
      # 当前时间与上次操作的时间差大于1分钟(60s)时，执行更新
      if (currentTimeSec - lastTimeSec > 60) do
        # Hex.Shell.info("generate event hits!!")
        Eeb.Convert.convert_markdown_blogs_to_html()
        Eeb.Image.yank_images_from_origin()
        #Eeb.Index.generate_index_page()
        infos = Map.update!(infos, @statusflag, fn _x -> Time.now(:secs) end)
      end
      {:noreply, infos}
    else
      {:noreply, Map.put(infos, @statusflag, Time.now(:secs))}
    end
  end

  def handle_cast({:regenerate_index}, infos) do
    Eeb.Index.generate_index_page()
    {:noreply, infos}
  end

end
