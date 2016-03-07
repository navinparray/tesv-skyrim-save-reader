defmodule Parser.GlobalData.Papyrus do
  @moduledoc """
    parse data for papyrus section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Papyrus

  """

  use Bitwise

  def parse(data) do
    [header, rest0] = Parser.Utils.read_uint16(data)
    [str_count, rest1] = Parser.Utils.read_uint16(rest0)
    [strings, rest2] = Parser.Utils.read_wstring_list(str_count, rest1)
    [script_count, rest3] = Parser.Utils.read_uint32(rest2)
    [scripts, rest4] = read_scripts_structure(script_count, rest3)
    [script_instance_count, rest5] = Parser.Utils.read_uint32(rest4)
    [script_instance, rest6] = read_script_instance_structure(script_instance_count, rest5)
    [reference_count, rest7] = Parser.Utils.read_uint32(rest6)
    [reference, rest8] = read_reference_structure(reference_count, rest7)
    [array_info_count, rest9] = Parser.Utils.read_uint32(rest8)
    [array_info, rest10] = read_array_info_structure(array_info_count, rest9)
    [papyrus_runtime, rest11] = Parser.Utils.read_uint32(rest10)
    [active_script_count, rest12] = Parser.Utils.read_uint32(rest11)
    [active_script, rest13] = read_active_script_structure(active_script_count, rest12)
    [script_data, rest14] = read_script_data_structure(script_instance_count, rest13)

    # [reference_data, rest14] = read_reference_data_structure(reference_count, rest13)
    # [array_data, rest15] = read_array_data_structure(array_info_count, rest14)
    # [active_script_data, rest16] = read_active_script_Data_structure(active_script_count, rest15)
    # [function_message_count, rest17] = Parser.Utils.read_uint32(rest16)
    # [function_messages, rest18] = read_function_message_structure(function_message_count, rest17)
    # [suspended_stack_count1, rest19] = Parser.Utils.read_uint32(rest18)
    # [suspended_stacks_1, rest20] = read_suspended_stack_structure(suspended_stack_count1, rest19)
    # [suspended_stack_count2, rest21] = Parser.Utils.read_uint32(rest20)
    # [suspended_stacks_2, rest21] = read_suspended_stack_structure(suspended_stack_count2, rest21)
    # [unknown0, rest22] = Parser.Utils.read_uint32(rest21)


    # if ((unknown0 = 0) and (header >= 2))
    #   [unknown1, rest23] = Parser.Utils.read_uint32(rest22)
    # else
    #   [unknown1, rest23] = [[], rest22]
    # end

    # [unknown2_count, rest24] = Parser.Utils.read_uint32(rest23)
    # [unknown2, rest25] = Parser.Utils.read_uint32_list(unknown2_count, rest24)

    # if (header >= 4) do
    #   [queue_unbind_count, rest26] = Parser.Utils.read_uint32(rest25)
    #   [queue_unbinds, rest27] = read_queue_unbinds_structure(queue_unbind_count, 26)
    # else
    #   [queue_unbind_count, _] = [0, rest25]
    #   [queue_unbinds, rest27] = [[], rest25]
    # end

    # [save_file_version, rest28] = Parser.Utils.read_sint16(rest27)
    # [array_count1, rest29] = Parser.Utils.read_uint32(rest28)
    # [array1, rest30] = read_array1_structure(array_count1, rest29)
    # [array_count1a, rest31] = Parser.Utils.read_uint32(rest30)
    # [array1a, rest32] = read_array1_structure(array_count1a, rest31)
    # [array_count2, rest32] = Parser.Utils.read_uint32(rest32)
    # [array2, rest33] = read_array2_structure(array_count2, rest32)
    # [array_count3, rest34] = Parser.Utils.read_uint32(rest33)
    # [array3, rest35] = read_array3_structure(array_count3, rest34)
    # [array_count4, rest36] = Parser.Utils.read_uint32(rest35)
    # [array3, rest37] = read_array3_structure(array_count4, rest36)
    # [script_list_count, read38] = Parser.Utils.read_uint32(read37)
    # [script_list, read39] = Parser.Utils.read_w32string_list(script_list_count, read38)
    # [array_count4a, rest40] = Parser.Utils.read_uint32(rest39)
    # [array_count4b, rest41] = Parser.Utils.read_uint32(rest40)
    # [array4b, rest42] = read_array4b_structure(array_count4b, rest41)
    # [array_count4c, rest43] = Parser.Utils.read_uint32(rest42)
    # [array4c, rest44] = read_array4c_structure(array_count4c, rest43)
    # [array_count4d, rest45] = Parser.Utils.read_uint32(rest44)
    # [array4d, rest46] = read_array4d_structure(array_count4d, rest45)
    # [array_count5, rest47] = Parser.Utils.read_uint32(rest46)
    # [array5, rest48] = read_array5_structure(array_count5, rest47)
    # [array_count6, rest49] = Parser.Utils.read_uint32(rest48)
    # [array6, rest51] = read_array6_structure(array_count6, rest50)
    # [array_count7, rest52] = Parser.Utils.read_uint32(rest51)
    # [array7, rest53] = read_array7_structure(array_count7, rest52)
    # [array_count8, rest54] = Parser.Utils.read_uint32(rest53)
    # [array8, rest55] = read_array8_structure(array_count8, rest54)
    # [array_count9, rest56] = Parser.Utils.read_uint32(rest55)
    # [array9, rest57] = read_array9_structure(array_count9, rest56)
    # [array_count10, rest59] = Parser.Utils.read_uint32(rest58)
    # [array10, rest60] = read_array10_structure(array_count10, rest59)
    # [array_count11, rest61] = Parser.Utils.read_uint32(rest60)
    # [array11, rest62] = read_array11_structure(array_count11, rest61)
    # [array_count12, rest63] = Parser.Utils.read_uint32(rest62)
    # [array12, rest64] = read_array12_structure(array_count12, rest63)
    # [array_count13, rest65] = Parser.Utils.read_uint32(rest64)
    # [array13, rest66] = read_array13_structure(array_count13, rest65)
    # [array_count14, rest67] = Parser.Utils.read_uint32(rest66)
    # [array14, rest68] = read_array14_structure(array_count14, rest67)
    # [array_count15, rest69] = Parser.Utils.read_uint32(rest68)
    # [array15, rest70] = read_array15_structure(array_count15, rest69)

    record = [
      header: header,
      str_count: str_count,
      strings: strings,
      script_count: script_count,
      scripts: scripts,
      script_instance_count: script_instance_count,
      script_instance: script_instance,
      reference_count: reference_count,
      reference: reference,
      array_info_count: array_info_count,
      array_info: array_info,
      papyrus_runtime: papyrus_runtime,
      active_script_count: active_script_count,
      active_script: active_script,
      script_data: script_data
    ]

    [record, rest14]
  end

  defp read_scripts_structure(count, data) do

    recall = fn(data) ->
      [script_name, rest0] = Parser.Utils.read_uint16(data)
      [type, rest1] = Parser.Utils.read_uint16(rest0)
      [member_count, rest2] = Parser.Utils.read_uint32(rest1)
      [member_data, rest3] = read_member_data_structure(member_count, rest2)

      
      record = [
        script_name: script_name,
        type: type,
        member_count: member_count,
        member_data: member_data
      ]

      [record, rest3]
    end

    Parser.Utils.read_structure(
      count,
      data,
      recall
    )
  end

  defp read_member_data_structure(count, data) do

    recall = fn (data) ->
      [member_name, rest0] = Parser.Utils.read_uint16(data)
      [member_type, rest1] = Parser.Utils.read_uint16(rest0)

      record = [
        member_name: member_name,
        member_type: member_type
      ]

      [record, rest1]
    end
    Parser.Utils.read_structure(
      count,
      data,
      recall
    )
  end

  defp read_script_instance_structure(count, data) do

    Parser.Utils.read_structure(
      count,
      data,
      fn(data) ->
        [script_id, rest0] = Parser.Utils.read_uint32(data)
        [script_name, rest1] = Parser.Utils.read_uint16(rest0)
        [unknown2bits, rest2] = Parser.Utils.read_uint16(rest1)
        [unknown0, rest3] = Parser.Utils.read_sint16(rest2)
        [ref_id, rest4] = Parser.Utils.read_refid(rest3)
        [unknown1, rest5] = Parser.Utils.read_uint8(rest4)

        record = [
          script_id: script_id,
          script_name: script_name,
          unknown2bits: unknown2bits,
          unknown0: unknown0,
          ref_id: ref_id,
          unknown1: unknown1
        ]

        [record, rest5]
      end
    )
  end

  defp read_reference_structure(count, data) do
    Parser.Utils.read_structure(
      count,
      data,
      fn(data) ->
        [reference_id, rest0] = Parser.Utils.read_uint32(data)
        [type, rest1] = Parser.Utils.read_uint16(rest0)

        record = [
          reference_id: reference_id,
          type: type
        ]

        [record, rest1]
      end
    )
  end

  defp read_array_info_structure(count, data) do
    Parser.Utils.read_structure(
      count,
      data,
      fn(data) ->
        [array_id, rest0] = Parser.Utils.read_uint32(data)
        [type, rest1] = Parser.Utils.read_uint8(rest0)

        [ref_type, rest2] =
        case type do
          1 -> Parser.Utils.read_uint16(rest1)
          _ -> [[], rest1]
        end

        [length, rest3] = Parser.Utils.read_uint32(rest2)


        record = [
          array_id: array_id,
          type: type,
          ref_type: ref_type,
          length: length
        ]

        [record, rest3]
      end
    )
  end

  defp read_active_script_structure(count, data) do
    Parser.Utils.read_structure(
      count,
      data,
      fn(data) ->
        [script_id, rest0] = Parser.Utils.read_uint32(data)
        [script_type, rest1] = Parser.Utils.read_uint8(rest0)

        record = [
          script_id: script_id,
          script_type: script_type
        ]

        [record, rest1]
      end
    )
  end

  defp read_script_data_structure(count, data) do
    Parser.Utils.read_structure(
      count,
      data,
      fn(data) ->
        [script_id, rest0] = Parser.Utils.read_uint32(data)
        [flag, rest1] = Parser.Utils.read_uint8(rest0)
        [type, rest3] = Parser.Utils.read_uint16(rest1)
        [unknown0, rest4] = Parser.Utils.read_uint32(rest3)
        [unknown1, rest5] = case band(flag, 0x04) do
          0x04 -> Parser.Utils.read_uint32(rest4)
          _ -> [0, rest4]
        end

        [member_count, rest6] = Parser.Utils.read_uint32(rest5)
        [variable, rest7] = read_variable_structure(member_count, rest6)

        record = [
          script_id: script_id,
          flag: flag,
          type: type,
          unknown0: unknown0,
          unknown1: unknown1,
          member_count: member_count,
          variable: variable
        ]

        [record, rest7]
      end
    )
  end

  defp read_variable_structure(count, data) do
    Parser.Utils.read_structure(
      count,
      data,
      fn(data) ->
        [type, rest0] = Parser.Utils.read_uint8(data)
        [data, rest1] = read_variable_data_structure(type, rest0)

        record = [
          type: type,
          data: data
        ]

        [record, rest1]
      end 
    )   
  end

  # Format for this structure
  # type  uint8     0 = Null (4) but not empty (4 bytes of zero)
  #                 1 = RefID (6)
  #                 2 = String (2)
  #                 3 = Integer (4)
  #                 4 = Float (4)
  #                 5 = Boolean (4)

  #                 11 = RefID Array (6, 2 bytes for type and 4 more bytes for array ID)
  #                 12 = String Array (4)   => Array ID
  #                 13 = Integer Array (4)  => Array ID
  #                 14 = Float Array (4)    => Array ID
  #                 15 = Boolean Array (4)  => Array ID

  # data  Depends on type     
  defp read_variable_data_structure(type, data) do
    
    [value, rest] = case type do
      x when x in [0,3,4,5,12,13,14,15] -> Parser.Utils.read_binary(4, data)
      x when x in [1,11] -> Parser.Utils.read_binary(6, data)
      2 -> Parser.Utils.read_binary(2, data)
      _ -> [[], data]
    end
    
    [value, rest]
  end
end
