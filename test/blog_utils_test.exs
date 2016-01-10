defmodule Eeb.BlogUtilsTest do
  alias Eeb.BlogUtils

  use ExUnit.Case, async: true

  test "get_file_name_without_suffix" do
    assert "abc" == BlogUtils.get_file_name_without_suffix("abc.md")
    assert "abc" == BlogUtils.get_file_name_without_suffix("/a/abc.md")
  end

end
