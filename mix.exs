defmodule Eeb.Mixfile do
  use Mix.Project

  def project do
    [app: :eeb,
     version: "0.1.0-dev",
     aliases: aliases,
     elixir: "~> 1.1",
     source_url: "https://github.com/aborn/eeb",
     homepage_url: "https://github.com/aborn/eeb",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     test_coverage: [tool: ExCoveralls]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [env: [default: :value],
     applications: [:logger,:tzdata,:cowboy],
     mod: {Eeb, []}
     ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:earmark, "~> 0.1.19", only: :dev},
     {:ex_doc, "~> 0.11.1", only: :dev},
     {:timex, "~> 1.0.0"},
     {:cowboy, "~> 1.0" },
     {:plug, "~> 0.14" },
     {:excoveralls, "~> 0.4", only: :test},
     {:tzdata, "== 0.1.8", override: true}]  ## https://github.com/bitwalker/timex/issues/86
  end

  defp aliases do
    [compile: ["deps.check", &unload_hex/1, "compile"],
     run: [&unload_hex/1, "run"],
     install: ["archive.build -o eeb.ez", "archive.install eeb.ez --force"],
     uninstall: ["archive.uninstall eeb.ez"]]
  end

  defp unload_hex(_) do
    paths = Path.join(Mix.Local.archives_path, "eeb*.ez") |> Path.wildcard

    Enum.each(paths, fn archive ->
      ebin = Mix.Archive.ebin(archive)
      Code.delete_path(ebin)

      {:ok, files} = :erl_prim_loader.list_dir(to_char_list(ebin))

      Enum.each(files, fn file ->
        file = List.to_string(file)
        size = byte_size(file) - byte_size(".beam")

        case file do
          <<name :: binary-size(size), ".beam">> ->
            module = String.to_atom(name)
            :code.delete(module)
            :code.purge(module)
          _ ->
            :ok
        end
      end)
    end)
  end

end
