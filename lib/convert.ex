defmodule Eeb.Convert do
  @moduledoc """
  将markdown文件转化成html文档
  """
  def post_path() do
    Path.join(__DIR__, "../posts/") |> Path.expand()
  end

  def debug() do
    IO.puts "path:" <> post_path()
  end
end

