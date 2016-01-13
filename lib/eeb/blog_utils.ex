defmodule Eeb.BlogUtils do
  @moduledoc """
  博客相关操作工具
  """

  alias Eeb.BlogPath
  use Timex
  
  @doc """
  获得所有博客的名字列表
  """
  def get_blog_file_name_list() do
    case File.ls(BlogPath.post_path()) do
      {:ok, files} ->
        # 按时间从最新到最老排序
        sorted_files = Enum.sort(files,  &(blog_file_time(&1) >= blog_file_time(&2)))
        Enum.filter(sorted_files, &(is_file_legal(&1)))
      {:error, reason} ->
        IO.puts "File.ls error #{reason}"
        []
      _ ->
        IO.puts "other error exception"
        []
    end
  end

  def get_blog_image_name_list() do
    listRoot = get_image_list(Path.join(BlogPath.post_path, "images")) |>
      Enum.map(fn(x) -> Path.join("images", x) end)
    listImages = get_image_list(BlogPath.post_path)
    listRoot ++ listImages
  end

  def get_image_list(path) do
    case File.ls(path) do
      {:ok, files} ->
        Enum.filter(files, &(is_image_file(&1)))
      {:error, reason} ->
        IO.puts "File.ls error #{reason}"
        []
      _ ->
        IO.puts "other error exception"
        []
    end
  end

  @doc """
  判断是否为图片
  """
  def is_image_file(fileName) do
    fileName =~ ~r".jpg$|.png$|.jpeg$"
  end
  
  @doc """
  文件名是否合法
  """
  def is_file_legal(x) do
    cond do
      x == "index.md" ->
        :false
      x == "README.md" ->
        :false
      true ->
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
        Earmark.to_html(content) |> get_title(get_file_name_without_suffix(filename))
      {:error, _} ->
        Hex.Shell.error("error in process file: #{filename}")
    end
  end
  
  @doc """
  获得文章标题
  """
  def get_title(content, default \\ "eeb") do
    list = String.split(content, ~r{<h1>|</h1>})
    cond do
      length(list) > 1 ->
        tl(list) |> hd
      true ->
        default
    end
  end

  @doc """
  获得文件名
  如： abc.md  输出： abc
  /ab/abd.md 输出：abd
  """
  def get_file_name_without_suffix(file) do
    fileName = String.split(file, ".") |> hd
    cond do
      fileName =~ ~r"/" ->
        String.split(fileName, "/") |> List.last()
      true ->
        fileName
    end
  end

  @doc """
  获得文件最后一次修改时间,返回字符串为ISO格式
  """
  def get_file_mtime_iso(file) do
    case File.lstat(file, [{:time, :local}]) do
      {:ok, stat} ->
        mtime = Date.from(stat.mtime, :local)
        case mtime |> DateFormat.format("{ISO}") do
          {:ok, timeString} ->
            timeString
          _ ->
            Hex.Shell.error("error convert timer")
        end
      {:error, _} ->
        Hex.Shell.error("error in read file #{file}")
    end
  end

  def get_file_mtime_posix(file) do
    case File.lstat(file, [{:time, :posix}]) do
      {:ok, stat} ->
        stat.mtime
      {:error, _} ->
        0
    end
  end

  def get_file_time_normal(file, type \\:mtime) do
    case File.lstat(file, [{:time, :local}]) do
      {:ok, stat} ->
        mtime = Date.from(stat.mtime, :local)
        ctime = Date.from(stat.ctime, :local)
        atime = Date.from(stat.atime, :local)
        case type do
          :ctime ->
            time = ctime
          :atime ->
            time = atime
          _ ->
            time = mtime
        end
        
        case time |> DateFormat.format("%Y-%m-%d %H:%M", :strftime) do
          {:ok, timeString} ->
            timeString
          _ ->
            "时间末知"
        end
      {:error, _} ->
        "时间末知"
    end
  end
  
  # 博客的修改时间
  defp blog_file_time(file) do
    get_file_mtime_posix(Path.join(BlogPath.post_path, file))
  end

  @doc """
  计算博客含有多少字
  """
  def count_word(str) do
    count_chinese_charator(str) + count_english_word(str)
  end

  defp count_chinese_charator(str) do
    Enum.filter(String.codepoints(str), fn(x) ->
      String.length(x) != byte_size(x)
    end) |> Enum.count
  end

  defp count_english_word(str) do
    Enum.filter(String.codepoints(str), fn(x) ->
      String.length(x) == byte_size(x)  and
      String.match?(x, ~r/[a-zA-Z ]+/)
    end) |> Enum.join |> String.split |> Enum.count
  end
end
