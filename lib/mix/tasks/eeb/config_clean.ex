defmodule Mix.Tasks.Eeb.Config.Clean do
  use Mix.Task

  @shortdoc "remove all eeb.config key vales"

  def run(_args) do
    remove? = Mix.shell.yes?("\nremove all eeb.config key value?")
    cond do
      remove? ->
        Eeb.ConfigUtils.remove_all_config()
      true ->
        true
        # do nothing
    end
  end
end
