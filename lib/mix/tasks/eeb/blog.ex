defmodule Mix.Tasks.Eeb.Blog do
  use Mix.Task
  
  @shortdoc "Generate static blogs from markdown files (in posts/ directory)."

  alias Eeb.Convert
  alias Eeb.Image
  
  def run(_args) do
    Mix.shell.info "start generate blog.."
    dir = Path.join(__DIR__, "./")
    Hex.Shell.info("#{dir}")
    Convert.convert_markdown_blogs_to_html()
    Mix.shell.info "finished the task!"
    Image.yank_images_from_origin()
  end
end
