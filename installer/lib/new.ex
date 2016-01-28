defmodule Mix.Tasks.Eeb.New do
  use Mix.Task

  @eeb Path.expand("../..", __DIR__)
  @version Mix.Project.config[:version]  
  @shortdoc "Create a new Eeb blog v#{@version} application."
  import Mix.Generator
  
  @moduledoc """
  Create a new Eeb blog.
  ## Examples
  mix eeb.new ~/hello_world
  """

  @new [
    {:eex, "template/mix.exs", "mix.exs"},
  ]
  
  @bare [
    {:text, "html/assets/app.js", "html/assets/app.js"},
    {:text, "html/assets/base.css", "html/assets/base.css"},
    {:text, "posts/eeb.md", "posts/eeb.md"}
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
    binding = [application_name: app, eeb_version: @version]
    copy_from(path, binding, @new)
    copy_static(path, binding)
  end
  
  defp copy_static(path, binding) do
    copy_from(path, binding, @bare)
    install? = Mix.shell.yes?("\nFetch and install dependencies?")

    File.cd!(path, fn ->
      mix? = install_mix(install?)
      extra = if mix?, do: [], else: ["$ mix deps.get"]
    end)
  end

  root = Path.join(__DIR__, "../") |> Path.expand
  
  for {format, source, _} <- @new ++ @bare do
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

  defp install_mix(install?) do
    maybe_cmd "mix deps.get", true, install? && Code.ensure_loaded?(Hex)
  end

  defp maybe_cmd(cmd, should_run?, can_run?) do
    cond do
      should_run? && can_run? ->
        cmd(cmd)
        true
      should_run? ->
        false
      true ->
        true
    end
  end

  defp cmd(cmd) do
    Mix.shell.info [:green, "* running ", :reset, cmd]
    :os.cmd(String.to_char_list(cmd))
  end

end
