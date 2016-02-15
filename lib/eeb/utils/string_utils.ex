defmodule Eeb.Utils.StringUtils do

  @moduledoc """
  util methods for deal with string.
  """

  def to_integer(str) do
    if is_binary(str) do
      String.to_integer(str)
    end
  end
end
