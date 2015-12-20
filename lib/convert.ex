defmodule Eeb.Convert do
  @moduledoc """
  将markdown文件转化成html文档
  """

  @doc """
  将markdown文件转换成html
  """
  def convert_markdown_blogs_to_html() do
    files = get_blog_files()
    html_path = html_path()
    unless html_path_check(html_path) do
      raise "Generate html failed!"
    end

    Enum.each(files, &(convert_each_item(&1)))
  end

  def convert_each_item(file) do
    blog_path = post_path()
    html_path = html_path()
    file_out_put = Path.join(html_path, get_file_name_without_suffix(file) <> ".html")
    file = Path.join(blog_path, file)
    
    Hex.Shell.info("process file:" <> file <> "...")
    case File.read(file) do
      {:ok, content} ->
        html_doc = Earmark.to_html(content)
        File.write(file_out_put, html_doc)
        Hex.Shell.info("success process file:" <> file)
      {:error, _} ->
        Hex.Shell.error("error in process file: #{file}")
    end
  end

  def get_file_name_without_suffix(file) do
    String.split(file, ".") |> hd
  end
  
  def html_path_check(html_path) do
    unless File.exists?(html_path) do
      case File.mkdir_p(html_path) do
        :ok ->
          Hex.Shell.info("create html path #{html_path} success")
        {:error, :eacces} ->
          Hex.Shell.error("missing search or write permissions for the parent directories of #{html_path}")
        {:error, :enospc} ->
          Hex.Shell.error("there is a no space left on the device")
        {:error, :enotdir} ->
          Hex.Shell.error("#{html_path}  is not a directory")
        _ ->
          Hex.Shell.error("unknown exception")
      end
    end
    
    is_path_dir = File.dir?(html_path)
    unless is_path_dir do
      Hex.Shell.error("#{html_path}  is not a directory")
    end

    is_path_dir
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

  def html_path() do
    Path.join(__DIR__, "../html/") |> Path.expand()
  end
  
  def debug() do
    IO.puts "path:" <> post_path()
  end
end

