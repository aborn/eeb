defmodule Mix.Tasks.Eeb.Blog do
  use Mix.Task
  
  @shortdoc "Generate static blogs from markdown files in posts/"

  alias Eeb.Convert
  alias Eeb.Image
  
  def run(_args) do
    Mix.shell.info "start generate blog.."
    Convert.convert_markdown_blogs_to_html()
    Mix.shell.info "finished the task!"
    Image.yank_images_from_origin()
  end
end
