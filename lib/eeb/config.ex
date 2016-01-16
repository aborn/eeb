defmodule Eeb.Config do
  defstruct [
    version: nil,
    project: nil,
    highlight: "9.0.0",   # highlight.js的版本号
    blog_slogan: "elixir extendable blog, aha!",
    blog_name: "eeb",
    blog_github: "https://github.com/aborn/eeb"
  ]
end
