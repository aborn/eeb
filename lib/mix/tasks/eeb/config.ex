defmodule Mix.Tasks.Eeb.Config do
  use Mix.Task

  @shortdoc "Reads or update eeb config"

  @moduledoc """
  Reads or updates eeb configuration file.
      mix eeb.config KEY [VALUE]
  ## Config keys
     * `blog_path` - blog file path
     * `blog_name` - blog name config
     * `blog_slogan` - blog slogan config
  ##
  """

  def run(args) do
    case args do
      [key] ->
        case Keyword.fetch(Eeb.ConfigUtils.read, :"#{key}") do
          {:ok, value} -> Hex.Shell.info inspect(value, pretty: true)
          :error -> Mix.raise "Config does not contain a key #{key}"
        end
      [key, value] ->
        Eeb.ConfigUtils.update([{:"#{key}", value}])
        Hex.Shell.info "#{key}: #{inspect(value, pretty: true)}"
      _ ->
        Mix.raise "Invalid arguments, expected: mix eeb.config KEY [VALUE]"
    end
  end
  
end
