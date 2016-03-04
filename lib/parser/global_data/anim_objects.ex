defmodule Parser.GlobalData.AnimObjects do
  @moduledoc """
    parse data for anim objects section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Anim_Objects

    count                     uint32
    objects                   AnimObjects[count]

    AnimObjects structure

    achr                      RefId
    anim                      RefId
    unknown                   uint8
  """

  def parse(data) do
    [count, rest] = Parser.Utils.read_uint32(data)

    [objects, _] = parse_anim_objects_data(count, rest)

    [
      count: count,
      objects: objects
    ]
  end

  defp parse_anim_objects_data(count, data) do
    parse_anim_objects_record(count, data, [])
  end

  defp parse_anim_objects_record(0, data, acc) do
    [acc, data]
  end

  defp parse_anim_objects_record(count, data, acc) do
    [achr, rest] = Parser.Utils.read_refid(data)
    [anim, rest1] = Parser.Utils.read_refid(rest)
    [unknown, rest2] = Parser.Utils.read_uint8(rest1)

    anim_object = [
      achr: achr,
      anim: anim,
      unknown: unknown
    ]
    
    parse_anim_objects_record(count - 1, rest2, acc ++ [anim_object])
  end
end
