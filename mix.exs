defmodule Eeb.Mixfile do
  use Mix.Project

  @version "0.1.1"
  
  def project do
    [app: :eeb,
     version: @version,
     aliases: aliases,
     elixir: "~> 1.1",
     description: description,
     package: package,
     source_url: "https://github.com/aborn/eeb",
     homepage_url: "https://github.com/aborn/eeb",
     deps: deps,
     test_coverage: [tool: ExCoveralls]]
  end

  def application do
    [
      applications: [:logger,:tzdata,:cowboy],
      mod: {Eeb, []}
    ]
  end

  defp description do
  """
  Elixir extendable blog.
  """
  end

  defp package do
    [
      maintainers: ["Aborn Jiang"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/aborn/eeb"}]
  end
  
  defp deps do
    [{:earmark, "~> 0.1.19", only: :dev},
     {:ex_doc, "~> 0.11.1", only: :docs},
     {:timex, "~> 1.0.0", only: :dev},
     {:cowboy, "~> 1.0", only: :dev},
     {:plug, "~> 0.14", only: :dev},
     {:excoveralls, "~> 0.4", only: :test},
     {:tzdata, "~> 0.1.8", only: :dev}]  ## https://github.com/bitwalker/timex/issues/86
  end

  defp aliases do
    [install: ["archive.build -o archives/eeb.ez", "archive.install archives/eeb.ez --force"],
     uninstall: ["archive.uninstall eeb.ez"]]
  end
  
end
