defmodule Parser.GlobalData.MagicFavorites do
  @moduledoc """
    parse data for magic favorites data section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Magic_Favorites

    format of the structure is (Variable Sized)


    count0                  vsval
    favorite_magics         RefId[count0]   (Spells, shouts, abilities etc.)
    count1                 vsval
    magic_hot_keys          RefId[count1]   (Hotkeys correspond to the position of magic in this array)

  """

  def parse(data) do
    {count0, rest} = Parser.Utils.read_vsval(data)

    {favorite_magics, rest1} = Parser.Utils.read_refid_list(count0, rest)

    {count1, rest2} = Parser.Utils.read_vsval(rest1)

    {magic_hot_keys, _} = Parser.Utils.read_refid_list(count1, rest2)

    %{
      count0: count0,
      favorite_magics: favorite_magics,
      count1: count1,
      magic_hot_keys: magic_hot_keys
    }
  end
end
