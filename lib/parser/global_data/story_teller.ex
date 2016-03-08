defmodule Parser.GlobalData.StoryTeller do
  @moduledoc """
    parse data for story teller data section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/StoryTeller

    flag                  uint8       (either 0 or 1)

  """

  def parse(data) do
    {flag, _} = Parser.Utils.read_uint8(data)

    %{flag: flag}
  end
end
