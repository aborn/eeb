defmodule Mix.Tasks.Eeb.Deploy do
  use Mix.Task
  
  @shortdoc "Starts the eeb application."

  @moduledoc """
  Starts the eeb application.
  ## Command line
     * mix eeb.deploy
  """
  
  def run(args) do
    Mix.Task.run "app.start", args
    no_halt()
  end

  defp no_halt do
    unless iex_running?, do: :timer.sleep(:infinity)
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) && IEx.started?
  end

end
