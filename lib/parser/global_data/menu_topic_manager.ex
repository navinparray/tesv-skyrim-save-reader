defmodule Parser.GlobalData.MenuTopicManager do
  @moduledoc """
    parse data for menu topic manager section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/MenuTopicManager

    unknown0                 RefId
    unknown1                 RefId
  """

  def parse(data) do
    [unknown0, rest] = Parser.Utils.read_refid(data)
    [unknown1, _] = Parser.Utils.read_refid(rest)

    [
      unknown0: unknown0,
      unknown1: unknown1
    ]
  end
end
