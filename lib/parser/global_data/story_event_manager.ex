defmodule Parser.GlobalData.StoryEventManager do
  @moduledoc """
    parse data for story event manager data section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Story_Event_Manager

    unknown0              uint32
    count0                vsval
    unknown1              unknown[count0]

  """

  def parse(data) do

      {unknown0, rest1} = Parser.Utils.read_uint32(data)
      {count0, rest2} = Parser.Utils.read_vsval(rest1)
      unknown1 = rest2

      %{
        unknown0: unknown0,
        count0: count0,
        unknown1: unknown1
      }
  end
end
