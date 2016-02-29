defmodule Parser.GlobalData.Combat do
  @moduledoc """
    parse data for combat section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Combat

    format of the structure is (Variable Sized)

    next_num        uint32 
    count0          vsval
    unknown         Unknown0[count0]
    count1          vsval
    unknown         Unknown1[count1]
    unknown         float
    unknown         vsval
    count2          vsval
    unknown         RefId[count2]
    unknown         float
    unknown         UnkStruct
    unknown         UnkStruct


    Unknown0 Structure (Variable Sized)
    unknown         uint32
    serial_num      uint32
    unknown         Unknown0_0


    Unknown0_0 Structure (Variable Sized)
    count0          vsval
    unknown         Unknown0_0_0[count0]
    count1          vsval
    unknown         Unknown0_0_1[count1]
    unknown         UnkStruct
    unknown         UnkStruct
    unknown         UnkStruct
    unknown         UnkStruct
    unknown         UnkStruct
    unknown         UnkStruct[11]
    unknown_flag    uint32
    unknown         Unknown0_0_2
    unknown         UnkStruct
    unknown         float
    unknown         float
    unknown         float
    unknown         float
    unknown         UnkStruct
    unknown         uint8


    Unknown0_0_0 Structure (162 Bytes)
    unknown         RefId
    unknown         uint32
    unknown         float
    unknown         uint16
    unknown         uint16
    target          RefId
    unknown         Position
    unknown         Position
    unknown         Position
    unknown         Position
    unknown         Position
    unknown         float
    unknown         float
    unknown         float
    unknown         float
    unknown         float
    unknown         float


    Unknown0_0_1 Structure (11 Bytes)

    unknwon         RefId
    unknown         float
    unknown         float


    Unknown0_0_2 Structure (Variable Sized)
    unknown         RefId
    unknown         UnkStruct
    unknown         UnkStruct
    unknown         float
    unknown         Position
    unknown         float
    count0          vsval
    unknown         Unknown0_0_2_0[count0]
    count1          vsval
    unknown         Unknown0_0_2_1[count1]
    unknown_flag    uint8
    unknown         Unknown0_0_2_2          This value is only present 
                                            if unknown_flag is not zero


    Unknown0_0_2_0 Structure (32 Bytes)
    unknown         Position
    unknown         unt32
    unknown         float

  
    Unknown0_0_2_1 Structure (9 Bytes)
    unknown         RefId
    unknown         RefId
    unknown         uint8
    unknown         uint8
    unknown         uint8


    Unknown0_0_2_2 Structure (Variable Sized)
    unknown         uint32
    unknown         uint32
    count0          uint32
    unknown         Unknown0_0_2_2_0[count0]
    unknown         RefId
    unknown         float
    unknown         float
    unknown         float
    unknown         float
    unknown         float
    unknown         RefId
    unknown         float
    unknown         RefId
    unknown         uint16
    unknown         uint8
    unknown         uint8
    unknown         float
    unknown         float


    Unknown0_0_2_2_0 Structure (Variable Sized)
    unknown         uint8
    count0          uint32
    unknown         uint8[count0]
    unknown         RefId
    unknown         uint32


    Unknown1 Structure (211 Bytes)
    unknown         RefId
    unknown         float
    unknown         Unknown1_0


    Unknown1_0 Structure (204 Bytes)
    unknonw         RefId
    unknonw         RefId
    unknonw         float
    unknonw         float
    unknonw         float
    x               float
    y               float
    z               float
    unknown         float
    unknown         float
    unknown         float
    unknown         float
    unknown         float
    unknown         float
    unknown         float
    unknown         float
    unknown         RefId

    Position Structure (24 Bytes)
    x               float
    y               float
    z               float
    cellid          RefId

    UnkStruct Structure (8 Bytes)

    unknown           float
    unknown           float

  """

  def parse(data) do

    <<
      next_num::little-unsigned-integer-size(32),
      count_0_byte::little-integer-size(8),
      rest::binary
    >> = data

    [count_0, rest1] = ParserUtils.read_vs_val(count_0_byte, rest)

    [unknown_1, rest2] = read_unknown0_structure(count_0, rest1)

    [
      next_num: next_num,
      count0: count_0,
      unknown_1: unknown_1,
      rest2: rest2
    ]
  end

  defp read_unknown0_structure(count, data) do
    IO.inspect data
    <<
      unknown_0::little-unsigned-integer-size(32),
      serial_num::little-unsigned-integer-size(32),
      rest::binary
    >> = data

    [unknown_data, rest1] = read_unknown0_0_structure(rest)

    [[
      unknown_0: unknown_0,
      serial_num: serial_num,
      unknown_data: unknown_data,
    ], rest]
  end

  defp read_unknown0_0_structure(data) do
    <<
      count_0_byte::little-integer-size(8),
      rest::binary
    >> = data

    [count_0, rest1] = ParserUtils.read_vs_val(count_0_byte, rest)



    [unknown_0, rest2] = read_unknown0_0_0_structure(count_0, rest1)

    [
      unknown_0,
      rest2
    ]

  end

  defp read_unknown0_0_0_structure(count, data) do
    #  RefId + uint32 + float + uint16 + uint16 + RefId
    #  + (Position * 5) + (float * 6)
    #  3 + 4 + 4 + 2 + 2 + 3
    #  + (15 * 5) + (4 * 6)
    #  = 117
    record_size = (count * 117)
    IO.inspect record_size
    <<
        unknown_data::binary-size(record_size),
        rest::binary
    >> = data
    structure_data = read_unknown0_0_0_record(data)

    [
        unknown0_0_0: structure_data,
        rest: rest
    ]
  end

  defp read_unknown0_0_0_record(data) do
    <<
      unknown0::binary-size(24),
      unknown1::little-unsigned-integer-size(32),
      unknown2::little-float-size(32),
      unknown3::little-unsigned-integer-size(16),
      unknown4::little-unsigned-integer-size(16),
      target::binary-size(24),
      unknown_position_0::binary-size(15),
      unknown_position_1::binary-size(15),
      unknown_position_2::binary-size(15),
      unknown_position_3::binary-size(15),
      unknown_position_4::binary-size(15),
      unknown5::little-float-size(32),
      unknown6::little-float-size(32),
      unknown7::little-float-size(32),
      unknown8::little-float-size(32),
      unknown9::little-float-size(32),
      unknown10::little-float-size(32)
    >> = data

    [
      unknown0: unknown0,
      unknown1: unknown1,
      unknown2: unknown2,
      unknown3: unknown3,
      unknown4: unknown4,
      target: target,
      unknown_position_0: convert_to_position_record(unknown_position_0),
      unknown_position_1: convert_to_position_record(unknown_position_1),
      unknown_position_2: convert_to_position_record(unknown_position_2),
      unknown_position_3: convert_to_position_record(unknown_position_3),
      unknown_position_4: convert_to_position_record(unknown_position_4),
      unknown5: unknown5,
      unknown6: unknown6,
      unknown7: unknown7,
      unknown8: unknown8,
      unknown9: unknown9,
      unknown10: unknown10
    ]
  end

  defp convert_to_position_record(data) do
    <<
      x::little-float-size(32),
      y::little-float-size(32),
      z::little-float-size(32),
      cell_id::binary-size(24)
    >> = data

    [
      x: x,
      y: y,
      z: z,
      cell_id: cell_id
    ]
    
  end
end