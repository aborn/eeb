defmodule Eeb.Utils.StringUtils do

  @moduledoc """
  util methods for string.
  """

  def to_integer(str) do
    if is_binary(str) do
      try do
        String.to_integer(str)
      rescue
        ArgumentError -> 0
      end
    end
  end
end
