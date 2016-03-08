defmodule Parser.GlobalData.Interface do
  @moduledoc """
    parse data for interface section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Interface

    format of the structure is (Variable Sized)

    shownHelpMsgCount           uint32
    shownHelpMsg                uint32[shownHelpMsgCount]
    Unknown0                    uint8
    lastUsedWeaponsCount        vsval
    lastUsedWeapons             RefId[lastUsedWeaponsCount]
    lastUsedSpellsCount         vsval
    lastUsedSpells              RefId[lastUsedSpellsCount]
    lastUsedShoutsCount         vsval
    lastUsedShouts              RefId[lastUsedShoutsCount]
    unknown1                    uint8
    unknown                     Unknown0 (only present in certain situation. Undetermined when.)

    Unknown0 Structure

    count1                      vsval
    unknown                     Unknown0_0[count]
    count2                      vsval
    unknown                     wstring[count2]
    unknown                     uint32


    Unknown0_0 Structure

    Unknown0                  wstring
    Unknown1                  wstring
    Unknown2                  uint32
    Unknown3                  uint32
    Unknown4                  uint32
    Unknown5                  uint32

  """
  def parse(data) do
    {shown_help_msg_count, rest0} = Parser.Utils.read_uint32(data)

    {shown_help_msg, rest1} = read_shown_help_msg_data(shown_help_msg_count, rest0)

    {unknown0, rest2} = Parser.Utils.read_uint8(rest1)

    {last_used_weapons_count, rest3} = Parser.Utils.read_vsval(rest2)

    {last_used_weapons, rest4} = read_last_used_data(last_used_weapons_count, rest3)

    {last_used_spells_count, rest5} = Parser.Utils.read_vsval(rest4)

    {last_used_spells, rest6} = read_last_used_data(last_used_spells_count, rest5)


    {last_used_shouts_count, rest7} = Parser.Utils.read_vsval(rest6)

    {last_used_shouts, rest8} = read_last_used_data(last_used_shouts_count, rest7)

    {unknown1, rest9} = Parser.Utils.read_uint8(rest8)

    {unknown0_data, _} = read_unknown0_structure(rest9)

    %{
      shown_help_msg_count: shown_help_msg_count,
      shown_help_msg: shown_help_msg,
      unknown0: unknown0,
      last_used_weapons_count: last_used_weapons_count,
      last_used_weapons: last_used_weapons,
      last_used_spells_count: last_used_spells_count,
      last_used_spells: last_used_spells,
      last_used_shouts_count: last_used_shouts_count,
      last_used_shouts: last_used_shouts,
      unknown1: unknown1,
      unknown0_data: unknown0_data
    }
  end

  defp read_shown_help_msg_data(count, data) do
    read_shown_help_msg(count, data, [])
  end

  defp read_shown_help_msg(0, data, acc) do
    {acc, data}
  end

  defp read_shown_help_msg(count, data, acc) do
    <<message::little-unsigned-integer-size(32),
    rest::binary
    >> = data

    read_shown_help_msg(count - 1, rest, acc ++ [message])
  end

  defp read_last_used_data(count, data) do
    read_last_used_record(count, data, [])
  end

  defp read_last_used_record(0, data, acc) do
    {acc, data}
  end

  defp read_last_used_record(count, data, acc) do
    <<last_used::binary-size(8),
      rest::binary
    >> = data

    read_last_used_record(count - 1, rest, acc ++ [last_used])
  end

  defp read_unknown0_structure(data) do
    {count1, rest0} = Parser.Utils.read_vsval(data)

    {unknown_data, rest2} = read_unknown0_0_data(count1, rest0, [])

    {count2, rest3} = Parser.Utils.read_vsval(rest2)

    {unknown1_data, rest4} = read_unknown_wstring_data(count2, rest3, [])

    {
      %{
        count1: count1,
        unknown: unknown_data,
        count2: count2,
        unknown: unknown1_data
      },
      rest4
    }
  end

  defp read_unknown0_0_data(0, data, acc) do
    {acc, data}
  end

  defp read_unknown0_0_data(count, data, acc) do
    <<unknown0_size :: little-unsigned-integer-size(16),
      unknown0 :: binary-size(unknown0_size),
      unknown1_size :: little-unsigned-integer-size(16),
      unknown1 :: binary-size(unknown1_size),
      unknown2 :: little-unsigned-integer-size(32),
      unknown3 :: little-unsigned-integer-size(32),
      unknown4 :: little-unsigned-integer-size(32),
      unknown5 :: little-unsigned-integer-size(32),
      rest::binary
    >> = data

    record = %{
      unknown0: unknown0,
      unknown1: unknown1,
      unknown2: unknown2,
      unknown3: unknown3,
      unknown4: unknown4,
      unknown5: unknown5
    }

    read_unknown0_0_data(count - 1, rest, acc + [record])
  end

  defp read_unknown_wstring_data(0, data, acc) do
    {acc, data}
  end

  defp read_unknown_wstring_data(count, data, acc) do
    <<string_size::little-unsigned-integer-size(16),
      unknown_string::binary-size(string_size),
      rest::binary
    >> = data

    read_unknown_wstring_data(count - 1, rest, acc ++ [unknown_string])
  end
end
