defmodule Eeb.Style do
  @moduledoc """
  处理前端样式
  """

  @doc """
  代码块的处理
  """
  def pretty_codeblocks(bin) do
    bin = Regex.replace(~r/<pre><code(\s+class=\"\")?>\s*iex&gt;/,
                        bin, ~S(<pre><code class="iex elixir">iex&gt;))
    bin = Regex.replace(~r/<pre><code(\s+class=\"\")?>/,
                        bin, ~S(<pre><code class="elixir">))
    bin = Regex.replace(~r/<pre><code(\s+class=\"elixir\")?>/,
                        bin, ~S(<pre><code class="elixir">))
    bin = Regex.replace(~r/<h1>/,
                        bin, ~S(<h1 class="ui header">))
    bin
  end

end
