defmodule Parser.GlobalData.Timer do
  @moduledoc """
    parse data for timer section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Timer

    unknown0                 uint32
    unknown1                 uint32
  """

  def parse(data) do
    {unknown0, rest} = Parser.Utils.read_uint32(data)
    {unknown1, _} = Parser.Utils.read_uint32(rest)

    %{
      unknown0: unknown0,
      unknown1: unknown1
    }
  end
end
