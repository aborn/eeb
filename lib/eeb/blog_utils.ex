defmodule Eeb.BlogUtils do
  @moduledoc """
  博客相关操作工具
  """

  alias Eeb.BlogPath
  
  @doc """
  获得所有博客的名字列表
  """
  def get_blog_file_name_list() do
    case File.ls(BlogPath.post_path()) do
      {:ok, files} ->
        Enum.filter(files, &(is_file_legal(&1)))
      {:error, reason} ->
        IO.puts "File.ls error #{reason}"
        []
      _ ->
        IO.puts "other error exception"
        []
    end
  end

  @doc """
  文件名是否合法
  """
  def is_file_legal(x) do
    case "index.md" do
      ^x ->
        :false
      _ ->
        is_file_supported(x)
    end
  end
  
  @doc """
  是否为支持类型的转换文件，暂时只保留以md结尾的文件
  TODO 将来是否支持.org格式文件?
  """
  def is_file_supported(x) do
    x =~ ~r".md$"
  end

  @doc """
  获得文章标题
  """
  def get_blog_title(filename) do
    case File.read(filename) do
      {:ok, content} ->
        Earmark.to_html(content) |> get_title
      {:error, _} ->
        Hex.Shell.error("error in process file: #{filename}")
    end
  end
  
  @doc """
  获得文章标题
  """
  def get_title(content) do
    list = String.split(content, ~r{<h1>|</h1>})
    cond do
      length(list) > 1 ->
        tl(list) |> hd
      true ->
        "eeb"
    end
  end

end
