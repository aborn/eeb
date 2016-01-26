defmodule Mix.Tasks.Eeb.Index do
  use Mix.Task
  
  @shortdoc "Generate/Regenerate blog index.html file."

  alias Eeb.Index
  
  def run(_args) do
    Mix.shell.info "start generate index.html.."
    Index.generate_index_page()
    Mix.shell.info "finished mix eeb.index task!"
  end
end
