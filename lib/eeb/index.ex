defmodule Eeb.Index do
  @filename "index.html"

  alias Eeb.Formatter.HTML.Templates
  alias Eeb.BlogPath
  alias Eeb.BlogUtils
  
  @moduledoc """
  处理博客的首页
  """

  def get_index_file_name do
    Path.join(BlogPath.html_path, @filename)
  end

  def generate_index_page() do
    files = BlogUtils.get_blog_file_name_list()
    blogItemList = build_blog_item_list(files)
    indexContent = Enum.map(blogItemList, fn item ->
      Templates.index_blog_item(item)
    end) |> Enum.join("<br/>")
    indexContent
  end

  def build_blog_item_list(files) do
    Enum.map(files, fn file ->
      blog_path = Path.join(BlogPath.post_path(), file)
      blog_url = BlogUtils.get_file_name_without_suffix(file) <> ".html"
      blog_title = BlogUtils.get_blog_title(blog_path)
      %Eeb.Blog {
        url: blog_url,
        title: blog_title,
        hits: "0",
        comments: "0",
        like: "0",
        time: "2016-01-10T10:16:06+08:00"
      }
    end)
  end
  
end
