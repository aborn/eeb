defmodule Eeb.Utils.SysUtils do

  def type(value) do
    cond do
      is_binary(value) ->
        :string
      is_boolean(value) ->
        :boolean
      is_atom(value) ->
        :atom
      is_integer(value) ->
        :integer
      is_float(value) ->
        :float
      is_tuple(value) ->
        :tuple
      is_list(value) ->
        :list
      true ->
        :unknown
    end
  end
end
