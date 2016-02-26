defmodule Eeb.Utils.StringUtilsTest do
  alias Eeb.Utils.StringUtils

  use ExUnit.Case, async: true

  test "to_integer" do
    assert StringUtils.to_integer("0") == 0
    assert StringUtils.to_integer("s") == 0
    assert StringUtils.to_integer("1") == 1
    assert StringUtils.to_integer(2) == 2
    assert StringUtils.to_integer(0) == 0
  end
end
