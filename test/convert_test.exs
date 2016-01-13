defmodule Eeb.ConvertTest do
  alias Eeb.Convert
  alias Eeb.BlogPath
  
  use ExUnit.Case, async: true

  test "test post path" do
    post_path = BlogPath.post_path()
    reg = ~r"eeb/posts$|book$"   # 必须以eeb/posts结尾
    assert post_path =~ reg
  end
end
