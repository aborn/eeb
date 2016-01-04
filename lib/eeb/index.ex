defmodule Eeb.Index do
  @filename "index.html"
  alias Eeb.BlogPath
  
  @moduledoc """
  处理博客的首页
  """

  def get_index_file_name do
    Path.join(BlogPath.html_path, @filename)
  end

end
