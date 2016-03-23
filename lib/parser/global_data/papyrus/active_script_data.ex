defmodule Parser.GlobalData.Papyrus.ActiveScriptData do

  def read({data, state}) do
    recall = fn(data) ->

      {rest, filled_state} = read_script_id({data, %Parser.Structs.GlobalData.ActiveScriptData{}})
        |> read_major_version()
        |> read_minor_version()
        |> read_unknown0()
        |> read_flag()
        |> read_unknown_byte()
        |> read_unknown2()
        |> read_unknown3()
        |> read_unknown4()
        |> read_stack_frame_count()
        |> Parser.GlobalData.Papyrus.StackFrame.read()
        |> read_unknown5()

      {filled_state, rest}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.active_script_count,
      data,
      recall
    )

    {rest, %{state | active_script_data: filled_state}}
  end

  defp read_script_id({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | script_id: value} }
  end

  defp read_major_version({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    {rest, %{state | major_version: value} }
  end

  defp read_minor_version({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    {rest, %{state | minor_version: value} }
  end

  defp read_unknown0({data, state}) do
    {rest, [variable_data | tail]} = Parser.GlobalData.Papyrus.Variable.read({data, []}, 1)

    {rest, %{state | unknown0: variable_data}}
  end

  defp read_flag({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    {rest, %{state | flag: value} }
  end

  defp read_unknown_byte({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    {rest, %{state | unknown_byte: value} }
  end

  defp read_unknown2({data, state}) do
    {value, rest} = case band(state.flag, 0x01) do
      0x01 -> Parser.Utils.read_uint32(data)
      _ -> {0, data}
    end

    {rest, %{state | unknown2: value} }
  end

  defp read_unknown3({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    {rest, %{state | unknown3: value} }
  end

  defp read_unknown4({data, state}) do

    {rest, value} = case state.unknown3 do
      1 -> read_unknown4_case1({data, state})
      2 -> read_unknown4_case2({data, state})
      2 -> read_unknown4_case3({data, state})
      _ -> {data, %{}}
    end

    {rest, %{state | unknown4: value} }
  end

  defp read_unknown4_case1({data, state}) do
    {char_count, rest0} = Parser.Utils.read_uint32(data)
    {string_value, rest1} = Parser.Utils.read_binary(char_count, rest0)

    {string_data, rest2} = read_unknown4_case_string_data(string_value, rest1)

    record = %{
      count: char_count,
      string_value: string_value,
      string_data: string_data
    }

    {rest2, record}
  end

  defp read_unknown4_case2({data, state}) do
    {rest, [variable_data | tail]} = Parser.GlobalData.Papyrus.Variable.read({data, []}, 1)

    {rest, variable_data}
  end

  defp read_unknown4_case3({data, state}) do
    {char_count, rest0} = Parser.Utils.read_uint32(data)
    {string_value, rest1} = Parser.Utils.read_binary(char_count, rest0)

    {string_data, rest2} = read_unknown4_case_string_data(string_value, rest1)

    {rest3, [variable_data | tail]} = Parser.GlobalData.Papyrus.Variable.read({rest2, []}, 1)

    {rest, variable_data}

    record = %{
      count: char_count,
      string_value: string_value,
      string_data: string_data,
      variable_data: variable_data
    }

    {rest2, record}
  end

  defp read_unknown4_case_string_data(string_value, data) do
    case string_value do
      "QuestStage" -> read_unknown4_case_string_data_type1(data)
      "ScenePhaseResults" -> read_unknown4_case_string_data_type2(data)
      "SceneActionResults" -> read_unknown4_case_string_data_type2(data)
      "SceneResults" -> read_unknown4_case_string_data_type3(data)
      _ ->
        {data, %{}}
    end
  end

  defp read_unknown4_case_string_data_type1(data) do
    {field1, rest0} = Parser.Utils.read_refid(data)
    {field2, rest1} = Parser.Utils.read_uint16(rest0)
    {field3, rest2} = Parser.Utils.read_uint8(rest1)

    record = %{
      field1: field1,
      field2: field2,
      field3: field3
    }
    {rest2, record}
  end

  defp read_unknown4_case_string_data_type2(data) do
    {field1, rest0} = Parser.Utils.read_refid(data)
    {field2, rest1} = Parser.Utils.read_uint32(rest0)

    record = %{
      field1: field1,
      field2: field2
    }
    {rest1, record}
  end

  defp read_unknown4_case_string_data_type3(data) do
    {field1, rest0} = Parser.Utils.read_refid(data)

    record = %{
      field1: field1
    }
    {rest1, record}
  end

  defp read_stack_frame_count({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | stack_frame_count: value} }
  end
end
