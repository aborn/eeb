defmodule Mix.Tasks.Eeb.Index do
  use Mix.Task
  
  @shortdoc "generate/regenerate this index.html file for blog"

  alias Eeb.Index
  
  def run(args) do
    Mix.shell.info "start generate index.html.."
    Index.generate_index_page()
    Mix.shell.info "finished mix eeb.index task!"
  end
end
