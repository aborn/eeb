defmodule Eeb.BlogPath do
  @moduledoc """
  博客路径处理
  """
  
  @doc """
  得到博客文章的目录，默认为项目根目录下的posts
  """
  def post_path() do
    Path.join(__DIR__, "../../posts/") |> Path.expand()
  end

  def html_path() do
    Path.join(__DIR__, "../../html/") |> Path.expand()
  end

end
