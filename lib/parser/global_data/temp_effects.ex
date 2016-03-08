defmodule Parser.GlobalData.TempEffects do
@moduledoc """
  parse data for temp effects section of global data table

  format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Temp_Effects

  count0                        vsval
  unknown0                      Unknown0[count0]
  unknown1                      uint32
  count1                        vsval
  unknown1                      Unknown1[count1]
  count2                        vsval
  unknown2                      Unknown2[count2]

  Unknown0 Structure

  flag                          uint8
  unknown0                      RefId
  unknown1                      uint32
  unknown2                      RefId
  unknown3                      RefId
  unknown4                      float[3]
  unknown5                      float[3]
  unknown6                      float
  unknown7                      float
  unknown8                      float
  unknown9                      float[4]
  Unknown10                     uint8
  Unknown11                     uint8
  Unknown12                     uint8
  Unknown13                     uint8
  Unknown14                     float
  Unknown15                     uint8
  Unknown16                     float
  Unknown17                     float
  Unknown18                     float
  Unknown19                     float
  Unknown20                     float
  Unknown21                     unit8
  Unknown22                     unit8
  Unknown23                     unit32

  Unknown1 Structure

  unknown0                      uint32
  unknown1                      Unknown1_x (Seems to depend on the previous variable)

  Unknown1_Def Structure

  This is for types 1, 3, 4, 5, 7 and is also element of other types

  unknown0                      float
  unknown1                      float
  unknown2                      uint8
  unknown3                      uint32

  Unknown1_0 Structure

  This is for type 0

  Unknown0                      Unknown1_Def
  unknown1                      uint32[4]
  unknown2                      uint32[3]
  unknown3                      uint8[12]
  unknown4                      wstring
  unknown5                      RefId
  unknown6                      RefId
  unknown7                      uint32

  Unknown1_6 Structure

  This is for type 6

  unknown0                      Unknown1_Def
  unknown1                      uint8
  unknown2                      RefId
  flag                          uint8
  unknown3                      RefId[4]

  Unknown1_8 Structure

  This is for type 8

  unknown0                      Unknown1_Def
  unknown1                      uint8
  unknown2                      RefId
  unknown3                      uint8
  unknown4                      RefId[4]

  Unknown1_9 Structure

  This is for type 9

  unknown0                       Unknown1_8
  unknown1                       RefId
  unknown2                       Unknown1_9_0

  Unknown1_9_0 Structure

  length                        vsval
  unknown0                      uint8
  count0                        uint32
  unknown1                      Unknnown_1_9_0_0[count0]

  Unknown1_9_0_0 Structure

  unknown                      wstring
  count0                        uint32
  unknown0                      {wstring,uint32,wstring,uint32,uint32}[count0] (type1)
  count1                        uint32
  unknown1                      {wstring,uint32}[count1] (type2)
  count2                        uint32
  unknown2                      {wstring, float, {wstring, uint8, uint32}[2]}[count2] (type3)
  unknown2_1                    wstring
  count3                        uint32
  unknown3                      {wstring, uint8}[count3] (type4)
  count4                        uint32
  unknown4                      {wstring, wstring, uint32, uint32, uint16, uin16, uint16, uint8, uint8}[count4] (type5)
  count5                        uint32
  unknown5                      {wstring, uint32}[count5] (type2)
  count6                        uint32
  unknown6                      {wstring, uint32}[count6] (type2)
  count7                        uint32
  unknown7                      {wstring, uint32 count1, uint32 count2, uint16[count1], uint16[count2]}[count7] (type6)
  count8                        uint32
  unknown8                      {wstring, uint8}[count8] (type4)
  count9                        uint32
  unknown9                      {wstring, uint32[4], uint32[4], uint32[4], uint32, uint32}[count9] (type7)
  count10                       uint32
  unknown10                     {wstring, 3 x uint32[4], 3 x uint32[4], 3 x uint32[4], uint32, uint8}[count10] (type8)
  count11                       uint32
  unknown11                     {wstring, wstring}[count11] (type9)
  count12                       uint32
  Unknown12                     {uint16, uint32, uint32, uint32, uint8, uint32}[count12] (type10)

  Unknown1_10 Structure

  This is for type 10

  unknown0                      Unknown1_8
  unknown1                      float
  unknown2                      float
  unknown3                      float
  unknown4                      float
  unknown5                      uint32
  unknown6                      RefId
  unknown7                      RefId
  unknown8                      uint32


  Unknown1_11

  This is for type 11

  Unknown0                      Unknown1_8
  unknown1                      RefId
  unknown2                      uint8
  unknown3                      uint32[3]
  unknown4                      Unknown1_9_0


"""

  def parse(data) do

    {count0, rest} = Parser.Utils.read_vsval(data)

    {unknown0, rest1} = parse_unknown0_structure(count0, rest)

    {unknown1, rest2} = Parser.Utils.read_uint32(rest1)

    {count1, rest3} = Parser.Utils.read_vsval(rest2)

    {unknown2, rest4} = parse_unknown1_structure(count1, rest3)

    {count2, rest5} = Parser.Utils.read_vsval(rest4)

    {unknown3, _} = parse_unknown1_structure(count2, rest5)

    %{
      count0: count0,
      unknown0: unknown0,
      unknown1: unknown1,
      count1: count1,
      unknown2: unknown2,
      count2: count2,
      unknown3: unknown3
    }
  end

  defp parse_unknown0_structure(count, data) do
    parse_unknown0_record(count, data, [])
  end

  defp parse_unknown0_record(0, data, acc) do
    {acc, data}
  end

  defp parse_unknown0_record(count, data, acc) do
    {flag, rest} = Parser.Utils.read_uint8(data)
    {unknown0, rest0} = Parser.Utils.read_refid(rest)

    {unknown1, rest1} =
       case flag do
         0 -> [[], rest0]
         _ -> Parser.Utils.read_uint32(rest0)
       end

    {unknown2, rest2} = Parse.Utils.read_refid(rest1)
    {unknown3, rest3} = Parse.Utils.read_refid(rest2)
    {unknown4, rest4} = Parse.Utils.read_float_list(3, rest3)
    {unknown5, rest5} = Parse.Utils.read_float_list(3, rest4)
    {unknown6, rest6} = Parse.Utils.read_float(rest5)
    {unknown7, rest7} = Parse.Utils.read_float(rest6)
    {unknown8, rest8} = Parse.Utils.read_float(rest7)
    {unknown9, rest9} = Parse.Utils.read_float_list(4, rest8)
    {unknown10, rest10} = Parse.Utils.read_uint8(rest9)
    {unknown11, rest11} = Parse.Utils.read_uint8(rest10)
    {unknown12, rest12} = Parse.Utils.read_uint8(rest11)
    {unknown13, rest13} = Parse.Utils.read_uint8(rest12)
    {unknown14, rest14} = Parse.Utils.read_float(rest13)
    {unknown15, rest15} = Parse.Utils.read_uint8(rest14)
    {unknown16, rest16} = Parse.Utils.read_float(rest15)
    {unknown17, rest17} = Parse.Utils.read_float(rest16)
    {unknown18, rest18} = Parse.Utils.read_float(rest17)
    {unknown19, rest19} = Parse.Utils.read_float(rest18)
    {unknown20, rest20} = Parse.Utils.read_float(rest19)
    {unknown21, rest21} = Parse.Utils.read_uint8(rest20)
    {unknown22, rest22} = Parse.Utils.read_uint8(rest21)
    {unknown23, rest23} = Parse.Utils.read_uint32(rest22)

    record = %{
      flag: flag,
      unknown0: unknown0,
      unknown1: unknown1,
      unknown2: unknown2,
      unknown3: unknown3,
      unknown4: unknown4,
      unknown5: unknown5,
      unknown6: unknown6,
      unknown7: unknown7,
      unknown8: unknown8,
      unknown9: unknown9,
      unknown10: unknown10,
      unknown11: unknown11,
      unknown12: unknown12,
      unknown13: unknown13,
      unknown14: unknown14,
      unknown15: unknown15,
      unknown16: unknown16,
      unknown17: unknown17,
      unknown18: unknown18,
      unknown19: unknown19,
      unknown20: unknown20,
      unknown21: unknown21,
      unknown22: unknown22,
      unknown23: unknown23
    }

    parse_unknown0_record(count - 1, rest23, acc ++ [record])
  end

  defp parse_unknown1_structure(count, data) do
    parse_unknown1_record(count, data, [])
  end

  defp parse_unknown1_record(0, data, acc) do
    {acc, data}
  end

  defp parse_unknown1_record(count, data, acc) do
    {unknown0, rest} = Parser.Utils.read_uint32(data)

    {unknown1, rest1} = parse_unknown1_def_structure(unknown0, rest)

    record = %{
      unknown0: unknown0,
      unknown1: unknown1
    }

    parse_unknown1_record(count - 1, rest1, acc ++ [record])
  end

  defp parse_unknown1_def_structure(type, data) when (type in [1, 3, 4, 5, 7]) do
    {unknown0, rest0} = Parser.Utils.read_float(data)
    {unknown1, rest1} = Parser.Utils.read_float(rest0)
    {unknown2, rest2} = Parser.Utils.read_uint8(rest1)
    {unknown3, rest3} = Parder.Utils.read_uint32(rest2)

    {
      %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3
      },
      rest3
    }
  end

  defp parse_unknown1_def_structure(0, data) do
    {unknown0, rest0} = parse_unknown1_def_structure(1, data)
    {unknown1, rest1} = Parser.Utils.read_float_list(4, rest0)
    {unknown2, rest2} = Parser.Utils.read_uint32_list(3, rest1)
    {unknown3, rest3} = Parder.Utils.read_uint8_list(12, rest2)
    {unknown4, rest4} = Parder.Utils.read_wstring(rest3)
    {unknown5, rest5} = Parder.Utils.read_refid(rest4)
    {unknown6, rest6} = Parder.Utils.read_refid(rest5)
    {unknown7, rest7} = Parder.Utils.read_uint32(rest6)

    {
      %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3,
        unknown4: unknown4,
        unknown5: unknown5,
        unknown6: unknown6,
        unknown7: unknown7
      },
      rest7
    }
  end

  defp parse_unknown1_def_structure(6, data) do
    {unknown0, rest0} = parse_unknown1_def_structure(1, data)
    {unknown1, rest1} = Parser.Utils.read_refid(rest0)
    {unknown2, rest2} = Parser.Utils.read_uint32(rest1)
    {unknown3, rest3} = Parder.Utils.read_uint32(rest2)
    {unknown4, rest4} = Parder.Utils.read_uint8(rest3)

    {
      %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3,
        unknown4: unknown4
      },
      rest4
    }
  end

  defp parse_unknown1_def_structure(8, data) do
    {unknown0, rest0} = parse_unknown1_def_structure(1, data)
    {unknown1, rest1} = Parser.Utils.read_uint8(rest0)
    {unknown2, rest2} = Parser.Utils.read_refid(rest1)
    {flag, rest3} = Parder.Utils.read_uint8(rest2)

    {unknown3, rest4} =
      case flag do
        0 -> {[], rest3}
        _ -> Parser.Utils.read_refid_list(4, rest3)
      end

    {
      %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        flag: flag,
        unknown3: unknown3
      },
      rest4
    }
  end

  defp parse_unknown1_def_structure(9, data) do
    {unknown0, rest0} = parse_unknown1_def_structure(8, data)
    {unknown1, rest1} = Parser.Utils.read_refid(rest0)
    {unknown2, rest2} = Parser.Utils.read_refid(rest1)
    {unknown3, rest3} = parse_unknown1_9_0_structure(rest2)

    {
      %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3
      },
      rest3
    }
  end

  defp parse_unknown1_def_structure(10, data) do
    {unknown0, rest0} = parse_unknown1_def_structure(8, data)
    {unknown1, rest1} = Parser.Utils.read_float(rest0)
    {unknown2, rest2} = Parser.Utils.read_float(rest1)
    {unknown3, rest3} = Parser.Utils.read_float(rest2)
    {unknown4, rest4} = Parser.Utils.read_float(rest3)
    {unknown5, rest5} = Parser.Utils.read_uint32(rest4)
    {unknown6, rest6} = Parser.Utils.read_refid(rest5)
    {unknown7, rest7} = Parser.Utils.read_refid(rest6)
    {unknown8, rest8} = Parser.Utils.read_uint32(rest7)

    {
      %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3,
        unknown4: unknown4,
        unknown5: unknown5,
        unknown6: unknown6,
        unknown7: unknown7,
        unknown8: unknown8
      },
      rest8
    }
  end

  defp parse_unknown1_def_structure(11, data) do
    {unknown0, rest0} = parse_unknown1_def_structure(8, data)
    {unknown1, rest1} = Parser.Utils.read_refid(rest0)
    {unknown2, rest2} = Parser.Utils.read_unit8(rest1)
    {unknown3, rest3} = Parser.Utils.read_uint32_list(3, rest2)
    {unknown4, rest4} = parse_unknown1_9_0_structure(rest3)

    {
      %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3,
        unknown4: unknown4
      },
      rest4
    }
  end

  defp parse_unknown1_def_structure(_, data) do
    {{}, data}
  end

  defp read_unknown1_9_0_0_record(0, data, acc) do
    {acc, data}
  end  

  defp read_unknown1_9_0_0_record(count, data, acc) do

    #
    #   Anonymous functions used to read some complex data structures
    #   There are 10 different types that need to be read
    #

    #
    #   format: {wstring,uint32,wstring,uint32,uint32}
    #
    afn_read_unknown1_9_0_0_type1_record = fn data ->
      {unknown0, rest0} = Parser.Utils.read_wstring(data)
      {unknown1, rest1} = Parser.Utils.read_uint32(rest0)
      {unknown2, rest2} = Parser.Utils.read_wstring(rest1)
      {unknown3, rest3} = Parser.Utils.read_uint32(rest2)
      {unknown4, rest4} = Parser.Utils.read_uint32(rest3)

      record = %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3,
        unknown4: unknown4
      }

      {record, rest4}
    end

    #
    #   format: {wstring,uint32}
    #
    afn_read_unknown1_9_0_0_type2_record = fn data ->
      {unknown0, rest0} = Parser.Utils.read_wstring(data)
      {unknown1, rest1} = Parser.Utils.read_uint32(rest0)

      record = %{
        unknown0: unknown0,
        unknown1: unknown1
      }

      {record, rest1}
    end

    #
    #   format: {wstring, float, {wstring, uint8, uint32}[2]}
    #
    afn_read_unknown1_9_0_0_type3_record = fn data ->
      {unknown0, rest0} = Parser.Utils.read_wstring(data)
      {unknown1, rest1} = Parser.Utils.read_float(rest0)

      {unknown2_0_0, rest2} = Parser.Utils.read_wstring(rest1)
      {unknown2_0_1, rest3} = Parser.Utils.read_uint8(rest2)
      {unknown2_0_2, rest4} = Parser.Utils.read_uint32(rest3)

      {unknown2_1_0, rest5} = Parser.Utils.read_wstring(rest4)
      {unknown2_1_1, rest6} = Parser.Utils.read_uint8(rest5)
      {unknown2_1_2, rest7} = Parser.Utils.read_uint32(rest6)

      record = %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: [
          %{
            unknown2_0_0: unknown2_0_0,
            unknown2_0_1: unknown2_0_1,
            unknown2_0_2: unknown2_0_2
          },
          %{
            unknown2_1_0: unknown2_1_0,
            unknown2_1_1: unknown2_1_1,
            unknown2_1_2: unknown2_1_2
          }
        ]
      }

      {record, rest7}
    end

    #
    #   format: {wstring, uint8}
    #
    afn_read_unknown1_9_0_0_type4_record = fn data ->
      {unknown0, rest0} = Parser.Utils.read_wstring(data)
      {unknown1, rest1} = Parser.Utils.read_uint8(rest0)

      record = %{
        unknown0: unknown0,
        unknown1: unknown1
      }

      {record, rest1}
    end

    #
    #   format: {wstring, wstring, uint32, uint32, uint16, uin16, uint16, uint8, uint8}
    #
    afn_read_unknown1_9_0_0_type5_record = fn data ->
      {unknown0, rest0} = Parser.Utils.read_wstring(data)
      {unknown1, rest1} = Parser.Utils.read_wstring(rest0)
      {unknown2, rest2} = Parser.Utils.read_uint32(rest1)
      {unknown3, rest3} = Parser.Utils.read_uint32(rest2)
      {unknown4, rest4} = Parser.Utils.read_uint16(rest3)
      {unknown5, rest5} = Parser.Utils.read_uint16(rest4)
      {unknown6, rest6} = Parser.Utils.read_uint16(rest5)
      {unknown7, rest7} = Parser.Utils.read_uint8(rest6)
      {unknown8, rest8} = Parser.Utils.read_uint8(rest7)

      record = %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3,
        unknown4: unknown4,
        unknown5: unknown5,
        unknown6: unknown6,
        unknown7: unknown7,
        unknown8: unknown8
      }

      {record, rest8}
    end

    #
    #   format: {wstring, uint32 count1, uint32 count2, uint16[count1], uint16[count2]}
    #
    afn_read_unknown1_9_0_0_type6_record = fn data ->
      {unknown0, rest0} = Parser.Utils.read_wstring(data)
      {count1, rest1} = Parser.Utils.read_uint32(rest0)
      {count2, rest2} = Parser.Utils.read_uint32(rest1)

      {unknown1, rest3} = Parser.Utils.read_uint16_list(count1, rest2)
      {unknown2, rest4} = Parser.Utils.read_uint16_list(count2, rest3)
      record = %{
        unknown0: unknown0,
        count1: count1,
        count2: count2,
        unknown1: unknown1,
        unknown2: unknown2
      }

      {record, rest4}
    end

    #
    #   format: {wstring, uint32[4], uint32[4], uint32[4], uint32, uint32}
    #
    afn_read_unknown1_9_0_0_type7_record = fn data ->
      {unknown0, rest0} = Parser.Utils.read_wstring(data)
      {unknown1, rest1} = Parser.Utils.read_uint32_list(4, rest0)
      {unknown2, rest2} = Parser.Utils.read_uint32_list(4, rest1)
      {unknown3, rest3} = Parser.Utils.read_uint32_list(4, rest2)
      {unknown4, rest4} = Parser.Utils.read_uint32(rest3)
      {unknown5, rest5} = Parser.Utils.read_uint32(rest4)

      record = %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3,
        unknown4: unknown4,
        unknown5: unknown5
      }

      {record, rest5}
    end

    #
    #   format: {wstring, 3 x uint32[4], 3 x uint32[4], 3 x uint32[4], uint32, uint8}
    #
    afn_read_unknown1_9_0_0_type8_record = fn data ->
      {unknown0, rest0} = Parser.Utils.read_wstring(data)
      {unknown1, rest1} = Parser.Utils.read_structure(
        3,
        rest0,
        fn(data) ->
          Parser.Utils.read_uint32_list(4, data)
        end
      )
      {unknown2, rest2} = Parser.Utils.read_structure(
        3,
        rest1,
        fn(data) ->
          Parser.Utils.read_uint32_list(4, data)
        end
      )
      {unknown3, rest3} = Parser.Utils.read_structure(
        3,
        rest2,
        fn(data) ->
          Parser.Utils.read_uint32_list(4, data)
        end
      )
      {unknown4, rest4} = Parser.Utils.read_uint32(rest3)
      {unknown5, rest5} = Parser.Utils.read_uint8(rest4)

      record = %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3,
        unknown4: unknown4,
        unknown5: unknown5
      }

      {record, rest5}
    end

    #
    #   format: {uint16, uint32, uint32, uint32, uint8, uint32}
    #
    afn_read_unknown1_9_0_0_type9_record = fn data ->
      {unknown0, rest0} = Parser.Utils.read_uint16(data)
      {unknown1, rest1} = Parser.Utils.read_uint32(rest0)
      {unknown2, rest2} = Parser.Utils.read_uint32(rest1)
      {unknown3, rest3} = Parser.Utils.read_uint32(rest2)
      {unknown4, rest4} = Parser.Utils.read_uint8(rest3)
      {unknown5, rest5} = Parser.Utils.read_uint32(rest4)

      record = %{
        unknown0: unknown0,
        unknown1: unknown1,
        unknown2: unknown2,
        unknown3: unknown3,
        unknown4: unknown4,
        unknown5: unknown5
      }

      {record, rest5}
    end

    #
    #   format: {wstring, wstring}
    #
    afn_read_unknown1_9_0_0_type10_record = fn data ->
      {unknown0, rest0} = Parser.Utils.read_wstring(data)
      {unknown1, rest1} = Parser.Utils.read_wstring(rest0)

      record = %{
        unknown0: unknown0,
        unknown1: unknown1
      }

      {record, rest1}
    end

    #
    # End of Anonymous Functions
    #

    {unknown0, rest0} = Parser.Utils.read_wstring(data)

    {count0, rest1} = Parser.Utils.read_uint32(rest0)
    {unknown1, rest3} = Parser.Utils.read_structure(count0, rest1, afn_read_unknown1_9_0_0_type1_record)

    {count1, rest4} = Parser.Utils.read_uint32(rest3)
    {unknown2, rest5} = Parser.Utils.read_structure(count1, rest4, afn_read_unknown1_9_0_0_type2_record)

    {count2, rest6} = Parser.Utils.read_uint32(rest5)
    {unknown3, rest7} = Parser.Utils.read_structure(count2, rest6, afn_read_unknown1_9_0_0_type3_record)

    {unknown4, rest8} = Parser.Utils.read_wstring(rest7)

    {count3, rest9} = Parser.Utils.read_uint3(rest8)
    {unknown5, rest10} = Parser.Utils.read_structure(count3, rest9, afn_read_unknown1_9_0_0_type4_record)

    {count4, rest11} = Parser.Utils.read_uint3(rest10)
    {unknown6, rest12} = Parser.Utils.read_structure(count4, rest11, afn_read_unknown1_9_0_0_type5_record)

    {count5, rest13} = Parser.Utils.read_uint3(rest12)
    {unknown7, rest14} = Parser.Utils.read_structure(count5, rest13, afn_read_unknown1_9_0_0_type2_record)

    {count6, rest15} = Parser.Utils.read_uint3(rest14)
    {unknown8, rest16} = Parser.Utils.read_structure(count6, rest15, afn_read_unknown1_9_0_0_type2_record)

    {count7, rest17} = Parser.Utils.read_uint3(rest16)
    {unknown9, rest18} = Parser.Utils.read_structure(count7, rest17, afn_read_unknown1_9_0_0_type6_record)

    {count8, rest19} = Parser.Utils.read_uint3(rest18)
    {unknown10, rest20} = Parser.Utils.read_structure(count8, rest19, afn_read_unknown1_9_0_0_type4_record)

    {count9, rest21} = Parser.Utils.read_uint3(rest20)
    {unknown11, rest22} = Parser.Utils.read_structure(count9, rest21, afn_read_unknown1_9_0_0_type7_record)

    {count10, rest23} = Parser.Utils.read_uint3(rest22)
    {unknown12, rest24} = Parser.Utils.read_structure(count10, rest23, afn_read_unknown1_9_0_0_type8_record)

    {count11, rest25} = Parser.Utils.read_uint3(rest24)
    {unknown13, rest26} = Parser.Utils.read_structure(count11, rest25, afn_read_unknown1_9_0_0_type9_record)

    {count12, rest27} = Parser.Utils.read_uint3(rest26)
    {unknown14, rest27} = Parser.Utils.read_structure(count12, rest26, afn_read_unknown1_9_0_0_type10_record)

    record = %{
      unknown0: unknown0,
      count0: count0,
      unknown1: unknown1,
      count1: count1,
      unknown2: unknown2,
      count2: count2,
      unknown3: unknown3,
      unknown4: unknown4,
      count3: count3,
      unknown5: unknown5,
      count4: count4,
      unknown6: unknown6,
      count5: count5,
      unknown7: unknown7,
      count6: count6,
      unknown8: unknown8,
      count7: count7,
      unknown9: unknown9,
      count8: count8,
      unknown10: unknown10,
      count9: count9,
      unknown11: unknown11,
      count10: count10,
      unknown12: unknown12,
      count11: count11,
      unknown13: unknown13,
      count12: count12,
      unknown14: unknown14
    }

    read_unknown1_9_0_0_record(count - 1, rest27, acc ++ [record])
  end    

  defp parse_unknown1_9_0_structure(data) do
    {length, rest0} = Parser.Utils.read_vsval(data)
    {unknown0, rest1} = Parser.Utils.read_uint8(rest0)
    {count0, rest2} = Parser.Utils.read_uint32(rest1)
    {unknown1, rest3} = parse_unnown1_9_0_0_structure(count0, rest2)

    {
      %{
        length: length,
        unknown0: unknown0,
        count0: count0,
        unknown1: unknown1
      },
      rest3
    }
  end

  defp parse_unnown1_9_0_0_structure(count, data) do
    read_unknown1_9_0_0_record(count, data, [])
  end
end
