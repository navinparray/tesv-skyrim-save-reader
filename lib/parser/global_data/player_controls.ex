defmodule Parser.GlobalData.PlayerControls do
  @moduledoc """
    parse data for player controls data section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/PlayerControls

    unknown0              uint8
    unknown1              uint8
    unknown2              uint8
    unknown3              uint16
    unknown4              uint8

  """

  def parse(data) do

      [unknown0, rest1] = Parser.Utils.read_uint8(data)
      [unknown1, rest2] = Parser.Utils.read_uint8(rest1)
      [unknown2, rest3] = Parser.Utils.read_uint8(rest2)
      [unknown3, rest4] = Parser.Utils.read_uint16(rest3)
      [unknown4, _] = Parser.Utils.read_uint8(rest4)

      [
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3,
        unknown4: unknown4
      ]
  end
end
