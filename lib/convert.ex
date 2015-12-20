defmodule Eeb.Convert do
  @moduledoc """
  将markdown文件转化成html文档
  """

  @doc
  def convert_markdown_blogs_to_html() do
    files = get_blog_files()
  end

  def get_blog_files() do
    case File.ls(post_path()) do
      {:ok, files} ->
        Enum.filter(files, &(is_file_supported(&1)))
      {:error, reason} ->
        IO.puts "File.ls error #{reason}"
        []
      _ ->
        IO.puts "other error exception"
        []
    end
  end

  @doc """
  是否为支持类型的转换文件，暂时只保留以md结尾的文件
  """
  def is_file_supported(x) do
    x =~ ~r".md$"
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

