defmodule Mix.Tasks.Eeb do
  @shortdoc "Prints Eeb help info."

  use Mix.Task

  def run(args) do
    {_opts, args, _} = OptionParser.parse(args)

    case args do
      [] -> help()
      _ ->
        Mix.raise "Invalid arguments, expected: mix eeb"
    end

  end

  defp help() do
    Mix.shell.info "Eeb v" <> Eeb.version
    Mix.shell.info "Eeb is elixir extensible blog platform."
    line_break()
    Mix.shell.info "mix eeb.blog generate blogs."
  end

  def line_break(), do: Mix.shell.info ""
  
end
