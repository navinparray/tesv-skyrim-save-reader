defmodule Parser.GlobalData.Papyrus.StackFrame do

  def read({data, state}) do
    recall = fn(data) ->

      {rest, filled_state} = read_variable_count({data, %Parser.Structs.GlobalData.StackFrame{}})
        |> read_flag()
        |> read_function_type()
        |> read_script_name()
        |> read_script_base_name()
        |> read_event()
        |> read_status()
        |> read_opcode_version()
        |> read_opcode_minor_version()
        |> read_return_type()
        |> read_function_docstring()
        |> read_function_user_flags()
        |> read_function_flags()
        |> read_function_parameter_count()
        |> Parser.GlobalData.Papyrus.FunctionParam.read()
        |> read_function_locals_count()
        |> Parser.GlobalData.Papyrus.FunctionLocal.read()
        |> read_function_opcode_count()
        |> Parser.GlobalData.Papyrus.OpcodeData.read()
        |> read_function_unknown3()
        |> read_function_unknown4()
        |> read_function_unknown5()

      {filled_state, rest}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.stack_frame_count,
      data,
      recall
    )

    {rest, %{state | stack_frame: filled_state}}
  end

  defp read_variable_count({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | variable_count: value} }
  end

  defp read_flag({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    {rest, %{state | flag: value} }
  end

  defp read_function_type({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    {rest, %{state | function_type: value} }
  end

  defp read_script_name({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | script_name: value} }
  end

  defp read_script_base_name({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | script_base_name: value} }
  end

  defp read_event({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | event: value} }
  end

  defp read_status({data, state}) do

    available? = ((0x00 == state.function_type) && (0x00 == band(state.flag, 0x01)))

    {value, rest} = case available? do
      true -> Parser.Utils.read_uint16(data)
      _ -> {0, data}
    end

    {rest, %{state | status: value} }
  end

  defp read_opcode_version({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | opcode_version: value} }
  end

  defp read_opcode_minor_version({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | opcode_minor_version: value} }
  end

  defp read_return_type({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | return_type: value} }
  end

  defp read_function_docstring({data, state}) do
    {value, rest} = Parser.Utils.read_int16(data)

    {rest, %{state | function_docstring: value} }
  end

  defp read_function_user_flags({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | function_user_flags: value} }
  end

  defp read_function_flags({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    {rest, %{state | function_flags: value} }
  end

  defp read_function_parameter_count({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | function_parameter_count: value} }
  end

  defp read_function_locals_count({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | function_locals_count: value} }
  end

  defp read_function_opcode_count({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | opcode_count: value} }
  end
end
