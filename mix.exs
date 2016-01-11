defmodule Eeb.Mixfile do
  use Mix.Project

  def project do
    [app: :eeb,
     version: "0.0.1",
     elixir: "~> 1.1",
     source_url: "https://github.com/aborn/eeb",
     homepage_url: "https://github.com/aborn/eeb",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger,:tzdata]]
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
     {:tzdata, "== 0.1.8", override: true}]  ## https://github.com/bitwalker/timex/issues/86
  end

  defp aliases do
    [compile: ["deps.check", &unload_hex/1, "compile"],
     run: [&unload_hex/1, "run"],
     install: ["archive.build -o eeb.ez", "archive.install eeb.ez --force"],
     certdata: [&certdata/1]]
  end

end
