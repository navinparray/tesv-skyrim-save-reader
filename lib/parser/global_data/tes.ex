defmodule Parser.GlobalData.TES do
  @moduledoc """
    parse data for TES section of the global data 

    format of section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/TES

    Format of TES structure

    count1      vsval
    unknown     Unknown0[count1]
    count2      vsval
    unknown     RefId[count2]
    count1      vsval
    unknown     RefId[count3]


    Format for Unknown0 structure (5 bytes)
  
    form_id     RefId
    unknown     uint16

    Format of RefId (3 bytes) (see http://www.uesp.net/wiki/Tes5Mod:Save_File_Format)

    byte0     uint8
    byte1     uint8
    byte2     uint8


  """

  def parse(data) do
    # extract the count1 data and return the rest of the data
    <<
      count1::little-integer-size(8),
      rest1::binary
    >> = data

    [unknown1_count, rest2] = ParserUtils.read_vs_val(count1, rest1)


    # calculate size of next data section
    unknown1_size = count1 * 5

    # extract next data section
    <<
      unknown1_bin_data::binary-size(unknown1_size),
      rest3::binary
    >> = rest2

    # parse next data section
    unknown1_data = extract_unknown0(unknown1_bin_data)

    # extract the count2 data and return the rest of the data
    <<
      count2::little-integer-size(8),
      rest4::binary
    >> = rest3


    [unknown2_count, rest5] = ParserUtils.read_vs_val(count2, rest4)

    # calculate size of next data section
    unknown2_size = count2 * 3

    # extract next data section
    <<
      unknown2_bin_data::binary-size(unknown2_size),
      rest6::binary
    >> = rest5

    # parse next data section
    unknown2_data = extract_unknown(unknown2_bin_data)

    # extract the count3 data and return the rest of the data
    <<
      count3::little-integer-size(8),
      rest7::binary
    >> = rest6


    unknown3_count = ParserUtils.read_vs_val(count3, rest7)

    # calculate size of next data section
    unknown3_size = count3 * 3

    # extract next data section
    <<
      unknown3_bin_data::binary-size(unknown3_size),
      _::binary
    >> = rest7

    # parse next data section
    unknown3_data = extract_unknown(unknown3_bin_data)  

    [
      count_1: unknown1_count,
      unknown_1: unknown1_data,     
      count_2: unknown2_count,
      unknown_2: unknown2_data,     
      count_3: unknown3_count,
      unknown_3: unknown3_data
    ] 
    # [
    #   count_1: count1,
    #   unknown_1: unknown1_data,     
    #   rest3: rest3
    # ] 

  end


  defp extract_unknown0_data(<<>>, acc) do
    acc
  end

  defp extract_unknown0_data(<<
    form_id::binary-size(3),
    unknown::little-unsigned-integer-size(16),
    rest::binary
    >>, acc) do
    extract_unknown_data(rest, acc ++ [[
      form_id: form_id,
      unknown: unknown
    ]])
  end

  defp extract_unknown0(data) do
    extract_unknown0_data(data, [])
  end


  defp extract_unknown_data(<<>>, acc) do
    acc
  end

  defp extract_unknown_data(<<
    ref_id::binary-size(3),
    rest::binary
    >>, acc) do
    extract_unknown_data(rest, acc ++ [[
      ref_id: ref_id
    ]])
  end 

  defp extract_unknown(data) do
    extract_unknown_data(data, [])
  end
end