defmodule EebNew.Mixfile do
  use Mix.Project

  @eeb_hex_latest_version "0.1.2"

  def project do
    [app: :eeb_new,
     version: @eeb_hex_latest_version,
     aliases: aliases,
     elixir: "~> 1.2"]
  end

  def application do
    [applications: []]
  end

  defp aliases do
    [install: ["archive.build -o archives/eeb.ez", "archive.install archives/eeb.ez --force"],
     uninstall: ["archive.uninstall eeb.ez"]]
  end

end
