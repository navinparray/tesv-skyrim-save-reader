defmodule Parser.GlobalData.ActorCauses do
  @moduledoc """
    parse data for actor causes section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Actor_Causes

    format of the structure is (Variable Sized)

    nextNum           uint32
    count             vsval
    unknown           Unknown0[count]


    Unknown0 Structure
    x                 float
    y                 float
    z                 float
    serialNum         uint32
    actorId           RefID

  """

  def parse(data) do

    {next_num, rest} = Parser.Utils.read_uint32(data)

    {count_0, rest1} = Parser.Utils.read_vsval(rest)

    unknown_1 = read_unknown0_structure(rest1)

    %{
      next_num: next_num,
      count0: count_0,
      unknown_1: unknown_1
    }
  end

  defp read_unknown0_structure(data) do

    read_unknown0_record(data, [])
  end

  defp read_unknown0_record(<<>>, acc) do
    acc
  end

  defp read_unknown0_record(<<
    x::little-float-size(32),
    y::little-float-size(32),
    z::little-float-size(32),
    serial_num::little-unsigned-integer-size(32),
    actor_id::binary-size(3),
    rest::binary
  >>, acc) do

    data_struct = %{
      x: x,
      y: y,
      z: z,
      serial_num: serial_num,
      actor_id: actor_id
    }

    read_unknown0_record(rest, acc ++ [data_struct])
  end
end
