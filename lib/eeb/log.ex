defmodule Eeb.Log do

  @doc """
  打出log日志
  """
  use Timex
  
  def log_conn(conn) do
    {:ok, timeNowStr} = Date.local |> DateFormat.format("{ISO}")
    if conn.request_path =~ ~r".html$|/$" do
      Hex.Shell.info("**** " <> timeNowStr <> " " <> conn.method <> " "<> conn.request_path)
    else
      Hex.Shell.info(" " <> conn.method <> " "<> conn.request_path)
    end
    {:ok}
  end

end
