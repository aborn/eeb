defmodule EebNew.Mixfile do
  use Mix.Project

  @eeb_hex_latest_version "0.1.3"

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
    [install: ["archive.build -o archives/eeb_new.ez", "archive.install archives/eeb_new.ez --force"],
     uninstall: ["archive.uninstall eeb_new.ez"]]
  end

end
