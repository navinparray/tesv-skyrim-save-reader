defmodule Parser.GlobalData.QuestStaticData do
  @moduledoc """
    parse data for quest static data section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Location_MetaData

    format of the structure is (Variable Sized)


    count0                  uint32
    unknown_0                QuestRunData_3[count0]
    count1                  uint32
    unknown_1                QuestRunData_3[count_1]
    count2                  uint32
    unknown_2                RefId[count2]
    count3                  uint32
    unknown_3                RefId[count3]
    count4                  uint32
    unknown_4                RefId[count4]
    count5                  uint32
    unknown_5                Unknown0[count5]
    unknown_6                uint8

    Unknown0 Structure

    unknown0_0              RefId
    count                   vsval
    unknown1                Unknown1[count]

    Unknown1 structure

    unknown1_0              uint32
    unknown1_2              uint32

    QuestRunData_3 structure

    unknown1                uint32
    unknown2                float
    count                   uint32
    QuestRunData_3_Item     QuestRunData_3_Item[count]


    QuestRunData_3_Item structure

    type                    uint32
    unknown                 RefId or uin32 (depends on type value: 1,2,4 are RefId, 3 is uint32)



  """

  def parse(data) do
    {count_0, rest} = Parser.Utils.read_uint32(data)

    {unknown_0, rest1} = parse_quest_run_data_3(count_0, rest)

    {count_1, rest2} = Parser.Utils.read_uint32(rest1)

    {unknown_1, rest3} = parse_quest_run_data_3(count_1, rest2)

    {count_2, rest4} = Parser.Utils.read_uint32(rest3)

    {unknown_2, rest5} = Parser.Utils.read_refid_list(count_2, rest4)

    {count_3, rest6} = Parser.Utils.read_uint32(rest5)

    {unknown_3, rest7} = Parser.Utils.read_refid_list(count_3, rest6)

    {count_4, rest8} = Parser.Utils.read_uint32(rest7)

    {unknown_4, rest9} = Parser.Utils.read_refid_list(count_4, rest8)

    {count_5, rest10} = Parser.Utils.read_vsval(rest9)

    {unknown_5, rest11} = parse_unknown0_data(count_5, rest10)

    {unknown6, _} = Parser.Utils.read_uint8(rest11)

    %{
      count_0: count_0,
      unknown0: unknown_0,
      count_1: count_1,
      unknown1: unknown_1,
      count_2: count_2,
      unknown_2: unknown_2,
      count_3: count_3,
      unknown_3: unknown_3,
      count_4: count_4,
      unknown_4: unknown_4,
      count_5: count_5,
      unknown_5: unknown_5,
      unknown6: unknown6
    }
  end

  defp parse_unknown0_data(count, data) do
    read_unknown0_record(count, data, [])
  end

  defp read_unknown0_record(0, data, acc) do
    {acc, data}
  end

  defp read_unknown0_record(count, data, acc) do
    {unknown0_0, rest} = Parse.Utils.read_refid(data)
    {count_0, rest1} = Parse.Utils.read_vsval(rest)
    {unknown1, rest2} = read_unknown1_list(count_0, rest1)

    record = %{
      unknown0_0: unknown0_0,
      count: count_0,
      unknown1: unknown1
    }

    read_unknown0_record(count - 1, rest2, acc ++ [record])
  end

  defp read_unknown1_list(count, data) do
    read_unknown1_record(count, data, [])
  end

  defp read_unknown1_record(0, data, acc) do
    {acc, data}
  end

  defp read_unknown1_record(count, data, acc) do
    {unknown1_0, rest} = Parse.Utils.read_uint32(data)
    {unknown1_2, rest1} = Parse.Utils.read_uint32(rest)

    record = %{
      uknown1_0: unknown1_0, 
      unknown1_2: unknown1_2
    }

    read_unknown1_record(count - 1, rest1, acc ++ [record])
  end

  defp parse_quest_run_data_3(count, data) do
    parse_quest_run_data_3_record(count, data, [])
  end

  defp parse_quest_run_data_3_record(0, data, acc) do
    {acc, data}
  end

  defp parse_quest_run_data_3_record(count, data, acc) do
    <<unknown1::little-unsigned-integer-size(32),
      unknown2::little-unsigned-integer-size(32),
      count0::little-unsigned-integer-size(32),
      rest::binary
    >> = data

    record = %{
      unknown1: unknown1, 
      unknown2: unknown2, 
      count: count0
    }

    parse_quest_run_3_data_records(count - 1, rest, acc ++ [record])
  end

  defp parse_quest_run_3_data_records(0, data, acc) do
    {acc, data}
  end

  defp parse_quest_run_3_data_records(count, data, acc) do
    <<
      type::little-unsigned-integer-size(32),
      rest::binary
    >> = data

    {unknown, rest1} = parse_unknown_data(type, rest)

    record = %{
      type: type, 
      unknown: unknown
    }

    parse_quest_run_3_data_records(count - 1, rest1, acc ++ [record])
  end

  #
  #   The type is 3, therefore it is a uint32
  #

  defp parse_unknown_data(3, data) do
    <<unknown::little-unsigned-integer-size(32),
      rest::binary
    >> = data

    {unknown, rest}
  end

  #
  #   The type id either 1,2 or 4 therefore it is a RefId
  #

  defp parse_unknown_data(_, data) do
    <<unknown::binary-size(3),
      rest::binary
    >> = data

    {unknown, rest}
  end
end
