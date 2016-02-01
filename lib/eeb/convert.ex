defmodule Eeb.Convert do

  @moduledoc """
  将markdown文件转化成html文档
  """

  alias Eeb.Formatter.HTML.Templates
  alias Eeb.ConfigUtils
  alias Eeb.Style
  alias Eeb.Index
  alias Eeb.BlogPath
  alias Eeb.BlogUtils
  alias Eeb.DuoshuoPlug

  @doc """
  convert markdown origin blog file to static html file
  Eeb.Convert.convert_markdown_blogs_to_html()
  """
  def convert_markdown_blogs_to_html() do
    files = BlogUtils.get_blog_file_name_list()
    html_path = BlogPath.html_path()
    unless html_path_check(html_path) do
      raise "Generate html failed!"
    end

    Enum.each(files, &(convert_each_item(&1)))
    Index.generate_index_page()
  end

  def convert_each_item(file) do
    blog_path = BlogPath.post_path()
    html_path = BlogPath.html_path()
    # here, blog_key represents uri
    blog_key = BlogUtils.get_file_name_without_suffix(file) <> ".html"
    file_out_put = Path.join(html_path, blog_key)
    file = Path.join(blog_path, file)

    title = BlogUtils.get_blog_title(file);

    Hex.Shell.info("process file:" <> file <> "...")
    case File.read(file) do
      {:ok, content} ->
        word_number = BlogUtils.count_word(content)
        html_bodycontent = Earmark.to_html(content) |> Style.pretty_codeblocks
        blog = get_blog_basic_info(file, word_number, title, blog_key); 
        html_header = get_template_header(blog)
        html_footer = get_template_footer()
        html_doc = content_concat(html_header, html_bodycontent, html_footer, blog)
        File.write(file_out_put, html_doc)
        Hex.Shell.info("success process file:" <> file)
        Hex.Shell.info("  output file:" <> file_out_put)
      {:error, _} ->
        Hex.Shell.error("error in process file: #{file}")
    end
  end

  def content_concat(header, content, footer, blog) do
    if DuoshuoPlug.is_use_duoshuo? do
      duoshuo = DuoshuoPlug.duoshuo_short_name() |> Templates.duoshuo_template(blog)
      header <> content <> duoshuo <> footer
    else
      header <> content <> footer
    end
  end
  
  def get_blog_basic_info(file, word_number \\ 0, title \\ "eeb", blog_key) do
    blog = %Eeb.Blog {
      url: blog_key,
      title: title,
      time: BlogUtils.get_file_time_normal(file, :ctime),
      mtime: BlogUtils.get_file_time_normal(file, :atime),
      word_count: word_number,
      hits: Eeb.Hit.Client.get_hits(blog_key)
    }
    blog
  end
  
  def get_template_header(blog) do
    config = ConfigUtils.build_config();
    Eeb.Hit.Client.make_sure_hit_server_started()
    # page = % {
    #   :title => title
    # }
    #
    Templates.head_template(config, blog)
  end

  def get_template_footer() do
    config = ConfigUtils.build_config();
    Templates.footer_template(config)
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

  def debug() do
    output = Path.join(BlogPath.html_path(), "test.html")
    outputBlog = Path.join(BlogPath.html_path(), "bb.html")
    config = %Eeb.Config{
      version: ConfigUtils.version()
    }
    blog = %Eeb.Blog{
      url: "index.html",
      title: "中国好声音",
      hits: "0",
      comments: "0",
      like: "0",
      time: "2016-01-10T10:16:06+08:00"
    }

    blog2 = %Eeb.Blog{
      url: "index.html",
      title: "中国好声音2",
      hits: "0",
      comments: "0",
      like: "0",
      time: "2016-01-10T10:16:06+08:00"
    }

    File.write!(output, Templates.test(config))
    File.write!(outputBlog, Templates.index_blog_item(blog) <> Templates.index_blog_item(blog2))
  end
end
