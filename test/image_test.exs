defmodule Eeb.ImageTest do
  alias Eeb.Image

  use ExUnit.Case, async: true

  test "get_image_file_name_without_path_info" do
    assert Image.get_image_file_name_without_path_info("a/b.png") == "b.png"
    assert Image.get_image_file_name_without_path_info("b.png") == "b.png"
  end
  
end

