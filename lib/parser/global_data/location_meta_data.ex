defmodule Parser.GlobalData.LocationMetaData do
  @moduledoc """
    parse data for location meta data section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Location_MetaData

    format of the structure is (Variable Sized)


    count1                  vsval
    unknown                 Unknown0[count1]


    Unknown0 Structure

    unknown0                RefId
    unknown1                uint32
    unknown2                uint32

  """

  def parse(data) do
    {count_0, rest1} = Parser.Utils.read_vsval(data)
    
    unknown = read_unknown0_structure(count_0, rest1, [])

    {
      count_0,
      unknown
    }

  end

  defp read_unknown0_structure(0, _, acc) do
    acc
  end

  defp read_unknown0_structure(count, data, acc) do
    <<
      unknown0::binary-size(3),
      unknown1::little-unsigned-integer-size(32),
      rest::binary
    >>  = data

    record = %{
      unknown0: unknown0,
      unknown1: unknown1
    }

    read_unknown0_structure(count - 1, rest, acc ++ [record])
  end
end
