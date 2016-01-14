defmodule Eeb.BlogPath do
  @moduledoc """
  博客路径处理
  """
  alias Eeb.ConfigUtils
  @blog_path_key :blog_path
  
  @doc """
  得到博客文章的目录，默认为项目根目录下的posts
  """
  def post_path() do
    default = Path.join(__DIR__, "../../posts/") |> Path.expand()
    config = ConfigUtils.read
    Keyword.get(config, @blog_path_key, default)
  end

  def html_path() do
    Path.join(__DIR__, "../../html/") |> Path.expand()
  end

end
