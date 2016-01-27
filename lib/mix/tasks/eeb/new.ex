defmodule Mix.Tasks.Eeb.New do
  use Mix.Task
  
  @version Mix.Project.config[:version]  
  @shortdoc "Create a new Eeb blog v#{@version} application."
  import Mix.Generator
  
  @moduledoc """
  Create a new Eeb blog.
  ## Examples
  mix eeb.new ~/hello_word
  """
  
  @bare [
    {:text, "html/assets/app.js", "html/assets/app.js"},
    {:text, "html/assets/base.css", "html/assets/base.css"},
  ]

  @switches [dev: :boolean, brunch: :boolean, ecto: :boolean,
             app: :string, module: :string, database: :string,
             binary_id: :boolean, html: :boolean]

  def run(argv) do
    {opts, argv, _} = OptionParser.parse(argv, switches: @switches)
    unless Version.match? System.version, "~> 1.1" do
      Mix.raise "Eeb v#{@version} requires at least Elixir v1.1.\n " <>
        "You have #{System.version}. Please update accordingly."
    end

    case argv do
      [] ->
        Mix.Task.run "help", ["eeb.new"]
      [path|_] ->
        app = opts[:app] || Path.basename(Path.expand(path))
        run(app, path)
    end
  end

  def run(app, path) do
    binding = [application_name: app]
    copy_static(path, binding)
  end
  
  defp copy_static(path, binding) do
    copy_from(path, binding, @bare)
  end

  root = Path.join(__DIR__, "../../../../") |> Path.expand
  
  for {format, source, _} <- @bare do
    unless format == :keep do
      @external_resource Path.join(root, source)
      def render(unquote(source)), do: unquote(File.read!(Path.join(root, source)))
    end
  end

  defp copy_from(target_dir, binding, mapping) when is_list(mapping) do
    application_name = Keyword.fetch!(binding, :application_name)
    for {format, source, target_path} <- mapping do
      target = Path.join(target_dir,
                         String.replace(target_path, "application_name", application_name))

      case format do
        :keep ->
          File.mkdir_p!(target)
        :text ->
          create_file(target, render(source))
        :eex  ->
          contents = EEx.eval_string(render(source), binding, file: source)
          create_file(target, contents)
      end
    end
  end

end
