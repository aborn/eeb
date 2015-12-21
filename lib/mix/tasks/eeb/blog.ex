defmodule Mix.Tasks.Eeb.Blog do
  use Mix.Task

  alias Eeb.Convert
  
  def run(args) do
    Mix.shell.info "start generate blog.."
    Convert.convert_markdown_blogs_to_html()
    Mix.shell.info "finished the task!"
  end
end
