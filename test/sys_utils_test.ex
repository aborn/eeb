defmodule Eeb.Utils.SysUtilsTest do
  alias Eeb.Utils.SysUtils

  use ExUnit.Case, async: true

  test "type" do
    assert SysUtils.type("") == :string
    assert SysUtils.type(1) == :integer
    assert SysUtils.type(true) == :boolean
    assert SysUtils.type(2.2) == :float
  end
end
