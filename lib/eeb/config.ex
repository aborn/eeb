defmodule Eeb.Config do
  defstruct [
    version: nil,
    project: nil,
    highlight: "9.1.0",   # highlight.js的版本号
    blog_slogan: "elixir extendable blog, aha!",
    blog_name: "eeb",
    blog_github: "https://github.com/aborn/eeb",
    blog_avatar: "http://upload.jianshu.io/users/upload_avatars/297930/02d576b98e6a.png?imageMogr/thumbnail/90x90/quality/100",
    visits: 0
  ]
end
