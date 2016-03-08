defmodule Parser.GlobalData.MenuControls do
  @moduledoc """
    parse data for menu controls section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/MenuControls

    unknown0                 uint8
    unknown1                 uint8
  """

  def parse(data) do
    {unknown0, rest} = Parser.Utils.read_uint8(data)
    {unknown1, _} = Parser.Utils.read_uint8(rest)

    %{
      unknown0: unknown0,
      unknown1: unknown1
    }
  end
end
