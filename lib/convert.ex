defmodule Eeb.Convert do
  @moduledoc """
  将markdown文件转化成html文档
  """

  def blog_files() do
    case File.ls(post_path()) do
      {:ok, [files]} ->
        files
      {:error, reason} ->
        IO.puts "read error #{reason}"
        []
      _ ->
        []
    end
  end
  
  @doc """
  得到博客文章的目录，默认为项目根目录下的posts
  """
  def post_path() do
    Path.join(__DIR__, "../posts/") |> Path.expand()
  end

  def debug() do
    IO.puts "path:" <> post_path()
  end
end

