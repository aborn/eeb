defmodule Eeb.Utils.SysUtils do

  def type(value) do
    cond do
      is_binary(value) ->
        :string
      is_atom(value) ->
        :atom
      is_boolean(value) ->
        :boolean
      is_integer(value) ->
        :integer
      is_float(value) ->
        :float
      true ->
        :unknown
    end
  end
end
