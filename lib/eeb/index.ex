defmodule Eeb.Index do
  @filename "index.html"

  alias Eeb.Formatter.HTML.Templates
  alias Eeb.BlogPath
  alias Eeb.BlogUtils
  alias Eeb.ConfigUtils
  
  @moduledoc """
  获得博客的首页的Path
  """
  def get_index_file_name do
    Path.join(BlogPath.html_path, @filename)
  end

  @doc """
  生成首页
  """
  def generate_index_page() do
    files = BlogUtils.get_blog_file_name_list()
    blogItemList = build_blog_item_list(files)

    # 获得博客列表内容
    indexContent = Enum.map(blogItemList, fn item ->
      Templates.index_blog_item(item)
    end) |> Enum.join("<br/>")
    
    indexFileName = get_index_file_name()
    html_header = Templates.index_head(ConfigUtils.build_config()) 
    html_footer = Templates.index_footer()
    indexHtmlContent = html_header <> indexContent <> html_footer
    File.write(indexFileName, indexHtmlContent)
  end

  defp build_blog_item_list(files) do
    Enum.map(files, fn file ->
      blog_path = Path.join(BlogPath.post_path(), file)
      blog_url = BlogUtils.get_file_name_without_suffix(file) <> ".html"
      blog_title = BlogUtils.get_blog_title(blog_path)
      blog_time = BlogUtils.get_file_mtime_iso(blog_path)
      %Eeb.Blog {
        url: blog_url,
        title: blog_title,
        hits: "0",
        comments: "0",
        like: "0",
        time: blog_time #"2016-01-10T10:16:06+08:00"
      }
    end)
  end
  
end
