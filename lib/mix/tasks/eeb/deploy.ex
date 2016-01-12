defmodule Mix.Tasks.Eeb.Deploy do
  use Mix.Task
  
  @shortdoc "deploy on localhost:4000"
  
  def run(args) do
    Mix.shell.info "deploy blog.."
    {:ok, _} = Plug.Adapters.Cowboy.http Server, []
    Mix.shell.info "finished deploy!"
  end
end
