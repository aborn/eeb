defmodule Eeb.Formatter.HTML.Templates do
  @moduledoc """
  模板处理
  """
  require EEx
  
  templates = [
    test: [:page],     # only for test
    footer_template: [:config],
    head_template: [:config, :page],
  ]

  Enum.each templates, fn({ name, args }) ->
    filename = Path.expand("templates/#{name}.eex", __DIR__)
    @doc false
    EEx.function_from_file :def, name, filename, args
  end
end
