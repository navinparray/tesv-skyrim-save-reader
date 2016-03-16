defmodule Parser.GlobalData.Papyrus do
  @moduledoc """
    parse data for papyrus section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Papyrus

  """

  use Bitwise

  def parse(data) do

    empty_state = %Parser.Structs.GlobalData.Papyrus{}

    {_rest, filled_state} = read_header({data, empty_state})
      |> read_str_count()
      |> read_strings()
      |> read_script_count()
      |> Parser.GlobalData.Papyrus.Script.read()
      |> read_script_instance_count()
      |> Parser.GlobalData.Papyrus.ScriptInstance.read()
      |> read_reference_count()
      |> Parser.GlobalData.Papyrus.Reference.read()
      |> read_array_info_count()
      |> Parser.GlobalData.Papyrus.ArrayInfo.read()
      |> read_papyrus_runtime()
      |> read_active_script_count()
      |> Parser.GlobalData.Papyrus.ActiveScript.read()
      |> Parser.GlobalData.Papyrus.ScriptData.read()

    IO.inspect filled_state.script_data

  end

  defp read_header({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | header: value} }
  end

  defp read_str_count({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | str_count: value} }
  end

  defp read_strings({data, state}) do
    {value, rest} = Parser.Utils.read_wstring_list(state.str_count, data)

    {rest, %{state | strings: value} }
  end

  defp read_script_count({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | script_count: value} }
  end

  defp read_script_instance_count({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | script_instance_count: value} }
  end

  defp read_reference_count({data, state}) do
      {value, rest} = Parser.Utils.read_uint32(data)

      {rest, %{state | reference_count: value}}
  end

  defp read_array_info_count({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | array_info_count: value}}
  end

  defp read_papyrus_runtime({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | papyrus_runtime: value}}
  end

  defp read_active_script_count({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | active_script_count: value}}
  end


  # defp read_scripts_structure(count, data) do
  #
  #   recall = fn(data) ->
  #     {script_name, rest0} = Parser.Utils.read_uint16(data)
  #     {type, rest1} = Parser.Utils.read_uint16(rest0)
  #     {member_count, rest2} = Parser.Utils.read_uint32(rest1)
  #     {member_data, rest3} = read_member_data_structure(member_count, rest2)
  #
  #
  #     record = %Parser.Structs.GlobalData.Script{
  #       script_name: script_name,
  #       script_type: type,
  #       member_count: member_count,
  #       member_data: member_data
  #     }
  #
  #     {record, rest3}
  #   end
  #
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     recall
  #   )
  # end
  #
  # defp read_member_data_structure(count, data) do
  #
  #   recall = fn (data) ->
  #     {member_name, rest0} = Parser.Utils.read_uint16(data)
  #     {member_type, rest1} = Parser.Utils.read_uint16(rest0)
  #
  #     record = %Parser.Structs.GlobalData.MemberData{
  #       member_name: member_name,
  #       member_type: member_type
  #     }
  #
  #     {record, rest1}
  #   end
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     recall
  #   )
  # end
  #
  # defp read_script_instance_structure(count, data) do
  #
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #       {script_id, rest0} = Parser.Utils.read_uint32(data)
  #       {script_name, rest1} = Parser.Utils.read_uint16(rest0)
  #       {unknown2bits, rest2} = Parser.Utils.read_uint16(rest1)
  #       {unknown0, rest3} = Parser.Utils.read_sint16(rest2)
  #       {ref_id, rest4} = Parser.Utils.read_refid(rest3)
  #       {unknown1, rest5} = Parser.Utils.read_uint8(rest4)
  #
  #       record = %Parser.Structs.GLobalData.ScriptInstance{
  #         script_id: script_id,
  #         script_name: script_name,
  #         unknown2bits: unknown2bits,
  #         unknown0: unknown0,
  #         ref_id: ref_id,
  #         unknown1: unknown1
  #       }
  #
  #       {record, rest5}
  #     end
  #   )
  # end
  #
  # defp read_reference_structure(count, data) do
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #       {reference_id, rest0} = Parser.Utils.read_uint32(data)
  #       {type, rest1} = Parser.Utils.read_uint16(rest0)
  #
  #       record = %Parser.Structs.GLobalData.References {
  #         reference_id: reference_id,
  #         type: type
  #       }
  #
  #       {record, rest1}
  #     end
  #   )
  # end
  #
  # defp read_array_info_structure(count, data) do
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #       {array_id, rest0} = Parser.Utils.read_uint32(data)
  #       {type, rest1} = Parser.Utils.read_uint8(rest0)
  #
  #       {ref_type, rest2} =
  #       case type do
  #         1 -> Parser.Utils.read_uint16(rest1)
  #         _ -> {[], rest1}
  #       end
  #
  #       {length, rest3} = Parser.Utils.read_uint32(rest2)
  #
  #
  #       record = %Parser.Structs.GlobalData.ArrayInfo{
  #         array_id: array_id,
  #         type: type,
  #         ref_type: ref_type,
  #         length: length
  #       }
  #
  #       {record, rest3}
  #     end
  #   )
  # end
  #
  # defp read_active_script_structure(count, data) do
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #       {script_id, rest0} = Parser.Utils.read_uint32(data)
  #       {script_type, rest1} = Parser.Utils.read_uint8(rest0)
  #
  #       record = %Parser.Structs.GlobalData.ActiveScripts{
  #         script_id: script_id,
  #         script_type: script_type
  #       }
  #
  #       {record, rest1}
  #     end
  #   )
  # end
  #
  # defp read_script_data_structure(count, data) do
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #       {script_id, rest0} = Parser.Utils.read_uint32(data)
  #       {flag, rest1} = Parser.Utils.read_uint8(rest0)
  #       {type, rest3} = Parser.Utils.read_uint16(rest1)
  #       {unknown0, rest4} = Parser.Utils.read_uint32(rest3)
  #       {unknown1, rest5} = case band(flag, 0x04) do
  #         0x04 -> Parser.Utils.read_uint32(rest4)
  #         _ -> {0, rest4}
  #       end
  #
  #       {member_count, rest6} = Parser.Utils.read_uint32(rest5)
  #       {variable, rest7} = read_variable_structure(member_count, rest6)
  #
  #       record = %Parser.Structs.GlobalData.ScriptData{
  #         script_id: script_id,
  #         flag: flag,
  #         script_type: type,
  #         unknown0: unknown0,
  #         unknown1: unknown1,
  #         member_count: member_count,
  #         member: variable
  #       }
  #
  #       {record, rest7}
  #     end
  #   )
  # end
  #
  # defp read_variable_structure(count, data) do
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #       {type, rest0} = Parser.Utils.read_uint8(data)
  #       {data, rest1} = read_variable_data_structure(type, rest0)
  #
  #       record = %Parser.Structs.GlobalData.Variable{
  #         type: type,
  #         data: data
  #       }
  #
  #       {record, rest1}
  #     end
  #   )
  # end
  #
  # # Format for this structure
  # # type  uint8     0 = Null (4) but not empty (4 bytes of zero)
  # #                 1 = RefID (6)
  # #                 2 = String (2)
  # #                 3 = Integer (4)
  # #                 4 = Float (4)
  # #                 5 = Boolean (4)
  #
  # #                 11 = RefID Array (6, 2 bytes for type and 4 more bytes for array ID)
  # #                 12 = String Array (4)   => Array ID
  # #                 13 = Integer Array (4)  => Array ID
  # #                 14 = Float Array (4)    => Array ID
  # #                 15 = Boolean Array (4)  => Array ID
  #
  # # data  Depends on type
  # defp read_variable_data_structure(type, data) do
  #
  #   {value, rest} = case type do
  #     x when x in [0,3,4,5,12,13,14,15] -> Parser.Utils.read_binary(4, data)
  #     x when x in [1,11] -> Parser.Utils.read_binary(6, data)
  #     2 -> Parser.Utils.read_binary(2, data)
  #     _ -> {[], data}
  #   end
  #
  #   {
  #     Parser.Utils.convert_to_list(value),
  #     rest
  #   }
  # end
  #
  # defp read_reference_data_structure(count, data) do
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #       {reference_id, rest0} = Parser.Utils.read_uint32(data)
  #       {flag, rest1} = Parser.Utils.read_uint8(rest0)
  #       {type, rest2} = Parser.Utils.read_uint16(rest1)
  #       {unknown0, rest3} = Parser.Utils.read_uint32(rest2)
  #       {unknown1, rest4} = Parser.Utils.read_uint32(rest3)
  #       {member_count, rest5} = Parser.Utils.read_uint32(rest4)
  #
  #       {member, rest6} = read_variable_structure(member_count, rest5)
  #
  #       record = %Parser.Structs.GlobalData.ReferenceData{
  #         reference_id: reference_id,
  #         flag: flag,
  #         type: type,
  #         unknown0: unknown0,
  #         unknown1: unknown1,
  #         member_count: member_count,
  #         member: member
  #       }
  #
  #       {record, rest6}
  #     end
  #   )
  # end
  #
  # defp read_array_data_structure(count, data) do
  #   {array_id, rest0} = Parser.Utils.read_uint32(data)
  #   {data, rest1} = read_variable_structure(count, rest0)
  #   IO.inspect array_id
  #   record = %Parser.Structs.GlobalData.ArrayData{
  #     array_id: array_id,
  #     data: data
  #   }
  #
  #   {record, rest1}
  # end
  #
  # #
  # # read the ActiveScriptData structure
  # #
  #
  # defp read_active_script_data_structure(count, data) do
  #
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #       {script_id, rest0} = Parser.Utils.read_uint32(data)
  #       {major_version, rest1} = Parser.Utils.read_uint8(rest0)
  #       {minor_version, rest2} = Parser.Utils.read_uint8(rest1)
  #
  #       {unknown0, rest3} = read_variable_structure(1, rest2)
  #       {flag, rest4} = Parser.Utils.read_uint8(rest3)
  #       {unknown_byte, rest5} = Parser.Utils.read_uint8(rest4)
  #       {unknown2, rest6} = Parser.Utils.read_uint32(rest5)
  #       {unknown3, rest7} = Parser.Utils.read_uint8(rest6)
  #
  #       {unknown4, rest8} = read_active_script_data_unknown4(rest7, unknown3)
  #
  #       {stack_frame_count, rest9} = Parser.Utils.read_uint32(rest8)
  #       {stack_frame, rest10} = read_stack_frame_structure(stack_frame_count, rest9)
  #       {unknown5, _} = Parser.Utils.read_uint8(rest10)
  #
  #       record = %Parser.Structs.GlobalData.ActiveScriptData{
  #         script_id: script_id,
  #         major_version: major_version,
  #         minor_version: minor_version,
  #         variable: unknown0,
  #         flag: flag,
  #         unknown_byte: unknown_byte,
  #         unknown2: unknown2,
  #         unknown3: unknown3,
  #         unknown4: unknown4,
  #         stack_frame_count: stack_frame_count,
  #         stack_frame: stack_frame,
  #         unknown5: unknown5
  #       }
  #
  #       {record, rest1}
  #     end
  #   )
  # end
  #
  # defp read_active_script_data_unknown4(data, 1) do
  #   {r1, rest0} = Parser.Utils.read_uint32(data)
  #   {r2, rest1} = Parser.Utils.read_binary(r1, rest0)
  #
  #   {fields, rest2} = case r2 do
  #     "QuestStage" -> fn ->
  #         {v1, resta} = Parser.Utils.read_refid(rest1)
  #         {v2, restb} = Parser.Utils.read_uin16(resta)
  #         {v3, restc} = Parser.Utils.read_uint8(restb)
  #         record = %{
  #           ref_id: v1,
  #           string_table_ref: v2,
  #           unknown: v3
  #         }
  #
  #         {record, restc}
  #     end
  #     "ScenePhaseResults" -> fn ->
  #       {v1, resta} = Parser.Utils.read_refid(rest1)
  #       {v2, restb} = Parser.Utils.read_uin32(resta)
  #       record = %{
  #         ref_id: v1,
  #         unknown: v2
  #       }
  #
  #       {record, restb}
  #     end
  #     "SceneActionResults" -> fn ->
  #       {v1, resta} = Parser.Utils.read_refid(rest1)
  #       {v2, restb} = Parser.Utils.read_uin32(resta)
  #       record = %{
  #         ref_id: v1,
  #         unknown: v2
  #       }
  #
  #       {record, restb}
  #     end
  #     "SceneResults" -> fn ->
  #       {v1, resta} = Parser.Utils.read_refid(rest1)
  #       record = %{
  #         ref_id: v1
  #       }
  #
  #       {record, resta}
  #     end
  #   end
  #
  #   record = %{
  #     count: r1,
  #     string_data: r2,
  #     other_data: fields
  #   }
  #
  #   {record, rest2}
  # end
  #
  # defp read_active_script_data_unknown4(data, 2) do
  #   read_variable_structure(1, data)
  # end
  #
  # defp read_active_script_data_unknown4(data, 3) do
  #   {record, rest0} = read_active_script_data_unknown4(1, data)
  #   {record1, rest1} = read_variable_structure(1, rest0)
  #
  #   full_recod_data = %{
  #     count: record.count,
  #     string_data: record.string_data,
  #     other_data: record.other_data,
  #     variable_data: record1
  #   }
  #
  #   {full_recod_data, rest1}
  # end
  #
  # defp read_active_script_data_unknown4(data, _) do
  #   {[], data}
  # end
  #
  # defp read_stack_frame_structure(count, data) do
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #       {variable_count, rest0} = Parser.Utils.read_uint32(data)
  #       {flag, rest1}= Parser.Utils.read_uint8(rest0)
  #       {function_type, rest2} = Parser.Utils.read_uint8(rest1)
  #       {script_name, rest3} = Parser.Utils.read_uint16(rest2)
  #       {script_base_name, rest4} = Parser.Utils.read_uint16(rest3)
  #       {event, rest5} = Parser.Utils.read_uint16(rest4)
  #       {status, rest6} = Parser.Utils.read_uint16(rest5)
  #       {opcode_version, rest7} = Parser.Utils.read_uint8(rest6)
  #       {opcode_minor_version, rest8} = Parser.Utils.read_uint8(rest7)
  #       {return_type, rest9} = Parser.Utils.read_uint16(rest8)
  #       {function_docstring, rest10} = Parser.Utils.read_uint16(rest9)
  #       {function_user_flags, rest11} = Parser.Utils.read_uint32(rest10)
  #       {function_flags, rest12} = Parser.Utils.read_uint8(rest11)
  #       {function_parameter_count, rest13} = Parser.Utils.read_uint16(rest12)
  #       {function_params, rest14} = read_function_params_structure(function_parameter_count, rest13)
  #       {function_locals_count, rest15} = Parser.Utils.read_uint16(rest14)
  #       {function_locals, rest16} = read_function_locals_structure(function_locals_count, rest15)
  #       {opcode_count, rest17} = Parser.Utils.read_uint16(rest16)
  #       {opcode_data, rest18} = read_opcode_data_structure(opcode_count, rest17)
  #       {unknown3, rest19} = Parser.Utils.read_uint32(rest18)
  #       {unknown4, rest20} = read_variable_structure(1, rest19)
  #       {unknown5, _rest21} = read_variable_structure(variable_count, rest20)
  #
  #       record = %Parser.Structs.GlobalData.StackFrame{
  #         variable_count: variable_count,
  #         flag: flag,
  #         function_type: function_type,
  #         script_name: script_name,
  #         script_base_name: script_base_name,
  #         event: event,
  #         status: status,
  #         opcode_version: opcode_version,
  #         opcode_minor_version: opcode_minor_version,
  #         return_type: return_type,
  #         function_docstring: function_docstring,
  #         function_user_flags: function_user_flags,
  #         function_flags: function_flags,
  #         function_parameter_count: function_parameter_count,
  #         function_params: function_params,
  #         function_locals_count: function_locals_count,
  #         function_locals: function_locals,
  #         opcode_count: opcode_count,
  #         opcode_data: opcode_data,
  #         unknown3: unknown3,
  #         unknown4: unknown4,
  #         unknown5: unknown5
  #       }
  #
  #       {record, rest2}
  #     end
  #   )
  # end
  #
  # defp read_function_params_structure(count, data) do
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #
  #       {param_name, rest0} = Parser.Utils.read_uint16(data)
  #       {param_type, rest1} = Parser.Utils.read_uint16(rest0)
  #
  #       record = %Parser.Structs.GlobalData.FunctionParam{
  #         param_name: param_name,
  #         param_type: param_type
  #       }
  #
  #       {record, rest1}
  #     end
  #   )
  # end
  #
  # defp read_function_locals_structure(count, data) do
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #
  #       {local_name, rest0} = Parser.Utils.read_uint16(data)
  #       {local_type, rest1} = Parser.Utils.read_uint16(rest0)
  #
  #       record = %Parser.Structs.GlobalData.FunctionLocal{
  #         local_name: local_name,
  #         local_type: local_type
  #       }
  #
  #       {record, rest1}
  #     end
  #   )
  # end
  #
  # defp read_opcode_data_structure(count, data) do
  #   Parser.Utils.read_structure(
  #     count,
  #     data,
  #     fn(data) ->
  #
  #       {opcode, rest0} = Parser.Utils.read_uint8(data)
  #
  #       opcode_base16 = Base.encode16(<<opcode>>)
  #       {param, rest1} = read_opcode_parameter(opcode_base16, rest0)
  #
  #       record = %Parser.Structs.GlobalData.OpcodeData{
  #         opcode: opcode,
  #         param: param
  #       }
  #
  #       {record, rest1}
  #     end
  #   )
  # end
  #
  # defp read_opcode_parameter(code, data) do
  #   case code do
  #     0x00 -> read_opcode_params(data, [])
  #     0x01 -> read_opcode_params(data, ['S', 'I', 'I'])
  #     0x02 -> read_opcode_params(data, ['S', 'F', 'F'])
  #     0x03 -> read_opcode_params(data, ['S', 'I', 'I'])
  #     0x04 -> read_opcode_params(data, ['S', 'F', 'F'])
  #     0x05 -> read_opcode_params(data, ['S', 'I', 'I'])
  #     0x06 -> read_opcode_params(data, ['S', 'F', 'F'])
  #     0x07 -> read_opcode_params(data, ['S', 'I', 'I'])
  #     0x08 -> read_opcode_params(data, ['S', 'F', 'F'])
  #     0x09 -> read_opcode_params(data, ['S', 'I', 'I'])
  #     0x0a -> read_opcode_params(data, ['S', 'A'])
  #     0x0b -> read_opcode_params(data, ['S', 'I'])
  #     0x0c -> read_opcode_params(data, ['S', 'F'])
  #     0x0d -> read_opcode_params(data, ['S', 'A'])
  #     0x0e -> read_opcode_params(data, ['S', 'A'])
  #     0x0f -> read_opcode_params(data, ['S', 'A', 'A'])
  #     0x10 -> read_opcode_params(data, ['S', 'A', 'A'])
  #     0x11 -> read_opcode_params(data, ['S', 'A', 'A'])
  #     0x12 -> read_opcode_params(data, ['S', 'A', 'A'])
  #     0x13 -> read_opcode_params(data, ['S', 'A', 'A'])
  #     0x14 -> read_opcode_params(data, ['L'])
  #     0x15 -> read_opcode_params(data, ['A', 'L'])
  #     0x16 -> read_opcode_params(data, ['A', 'L'])
  #     0x17 -> read_opcode_params(data, ['N', 'S', 'S', '*'])
  #     0x18 -> read_opcode_params(data, ['N', 'S', '*'])
  #     0x19 -> read_opcode_params(data, ['N', 'N', 'S', '*'])
  #     0x1a -> read_opcode_params(data, ['A'])
  #     0x1b -> read_opcode_params(data, ['S', 'Q', 'Q'])
  #     0x1c -> read_opcode_params(data, ['N', 'S', 'S'])
  #     0x1d -> read_opcode_params(data, ['N', 'S', 'A'])
  #     0x1e -> read_opcode_params(data, ['S', 'U'])
  #     0x1f -> read_opcode_params(data, ['S', 'S'])
  #     0x20 -> read_opcode_params(data, ['S', 'S', 'I'])
  #     0x21 -> read_opcode_params(data, ['S', 'I', 'A'])
  #     0x22 -> read_opcode_params(data, ['S', 'S', 'A', 'I'])
  #     0x23 -> read_opcode_params(data, ['S', 'S', 'A', 'I'])
  #     0x24 -> read_opcode_params(data, [])
  #   end
  # end
  #
  # defp read_opcode_params(data, []) do
  # end
  #
  # defp read_opcode_params(data, param_listing) do
  #
  #   get_params = fn (el) ->
  #     case el do
  #       '*' -> fn ->
  #         {extra_param_count, rest0} = Parser.Utils.read_uint32(data)
  #         read_parameter_structure(extra_param_count, rest0)
  #       end
  #       _ -> read_parameter_structure(1, data)
  #     end
  #   end
  #   #
  #   Enum.map(param_listing, get_params)
  # end
  #
  # defp read_parameter_structure(count, data) do
  #
  #   read_parameter_record(count, data, [])
  # end
  #
  # defp read_parameter_record(0, data, acc) do
  #   {acc, data}
  # end
  #
  # defp read_parameter_record(count, data, acc) do
  #   {param_type, rest0} = Parser.Utils.read_uint8(data)
  #
  #   {param_data, rest1} = case param_type do
  #     x when x in [1,2] -> Parser.Utils.read_uint16(rest0)
  #     3 -> Parser.Utils.read_uint32(rest0)
  #     4 -> Parser.Utils.read_float(rest0)
  #     5 -> Parser.Utils.read_uint8(rest0)
  #   end
  #
  #   record = %Parser.Structs.GlobalData.Parameter{
  #     param_type: param_type,
  #     param_data: param_data
  #   }
  #
  #   read_parameter_record(count - 1, rest1, acc ++ [record])
  # end
end
