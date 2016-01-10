defmodule Eeb.BlogUtils do
  @moduledoc """
  博客相关操作工具
  """

  @doc """
  获得所有博客的名字列表
  """
  def get_blog_file_name_list() do
    case File.ls(BlogPath.post_path()) do
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
  TODO 将来是否支持.org格式文件?
  """
  def is_file_supported(x) do
    x =~ ~r".md$"
  end
  
end
