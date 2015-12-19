defmodule Eeb.ConvertTest do
  alias Eeb.Convert
  use ExUnit.Case, async: true

  test "test post path" do
    post_path = Convert.post_path()
    reg = ~r"eeb/posts$"   # 必须以eeb/posts结尾
    assert post_path =~ reg
  end
end
