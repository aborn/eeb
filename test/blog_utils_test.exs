defmodule Eeb.BlogUtilsTest do
  alias Eeb.BlogUtils

  use ExUnit.Case, async: true

  test "get_file_name_without_suffix" do
    assert "abc" == BlogUtils.get_file_name_without_suffix("abc.md")
    assert "abc" == BlogUtils.get_file_name_without_suffix("/a/abc.md")
  end

  test "is_image_file" do
    assert :true == BlogUtils.is_image_file("abc.png")
    assert :true == BlogUtils.is_image_file("abc.jpg")
    assert :true == BlogUtils.is_image_file("abc.jpeg")
    assert :false == BlogUtils.is_image_file("abc.jpe")
    assert :false == BlogUtils.is_image_file("abc")
  end

  test "is_file_legal" do
    assert :true == BlogUtils.is_file_legal("index2.md")
    assert :false == BlogUtils.is_file_legal("index.md")
    assert :false == BlogUtils.is_file_legal("README.md")
    assert :false == BlogUtils.is_file_legal("_README.md")
    assert :false == BlogUtils.is_file_legal("_我是测试.md")
    assert :false == BlogUtils.is_file_legal("abc.doc")
    assert :false == BlogUtils.is_file_legal("abc.org")
  end
end
