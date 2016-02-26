defmodule Eeb.Utils.StringUtils do

  @moduledoc """
  util methods for string.
  """

  alias Eeb.Utils.SysUtils

  def to_integer(inputValue) do
    case SysUtils.type(inputValue) do
      :string ->
        try do
          String.to_integer(inputValue)
        rescue
          ArgumentError -> 0
        end
      :integer ->
        inputValue
      _ ->
        0
    end
  end
end
