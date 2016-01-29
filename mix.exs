defmodule Eeb.Mixfile do
  use Mix.Project

  @version "0.1.2"
  
  def project do
    [app: :eeb,
     version: @version,
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
    [ files: ["lib", "html", "installer", "posts", "LICENSE", "README.md", "mix.exs"],
      maintainers: ["Aborn Jiang"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/aborn/eeb"}]
  end
  
  defp deps do
    [{:earmark, "~> 0.1.19"},
     {:ex_doc, "~> 0.11.1", only: :dev},
     {:timex, "~> 1.0.0"},
     {:cowboy, "~> 1.0"},
     {:plug, "~> 0.14"},
     {:excoveralls, "~> 0.4", only: :test},
     {:tzdata, "~> 0.1.8"}]  ## https://github.com/bitwalker/timex/issues/86
  end
  
end
