defmodule Eeb.DuoshuoPlug do

  @duoshuo_short_name_key :duoshuo_short_name

  import Eeb.ConfigUtils
  
  def duoshuo_short_name do
    read_key_value(@duoshuo_short_name_key, nil)
  end

  def is_use_duoshuo? do
    case duoshuo_short_name do
      nil ->
        :false
      _ ->
        :true
    end
  end
  
end
