defmodule Parser.GlobalData.Papyrus.ScriptData do

  use Bitwise

    def read({data, state}) do
      recall = fn(data) ->

        {rest, filled_state} = read_script_id({data, %Parser.Structs.GlobalData.ScriptData{}})
          |> read_flag()
          |> read_script_type()
          |> read_unknown0()
          |> read_unknown1()
          |> read_member_count()


          {rest1, filled_state1} = Parser.GlobalData.Papyrus.Variable.read({rest, filled_state}, filled_state.member_count)

        {filled_state1, rest1}
      end

      {filled_state, rest} = Parser.Utils.read_structure(
        state.script_instance_count,
        data,
        recall
      )

      {rest, %{state | active_script: filled_state}}
    end

    defp read_script_id({data, state}) do
      {value, rest} = Parser.Utils.read_uint32(data)

      {rest, %{state | script_id: value} }
    end

    defp read_flag({data, state}) do
      {value, rest} = Parser.Utils.read_uint8(data)

      {rest, %{state | flag: value} }
    end

    defp read_script_type({data, state}) do
      {value, rest} = Parser.Utils.read_uint16(data)

      {rest, %{state | script_type: value} }
    end

    defp read_unknown0({data, state}) do
      {value, rest} = Parser.Utils.read_uint32(data)

      {rest, %{state | unknown0: value} }
    end

    defp read_unknown1({data, state}) do

      {value, rest} = case band(state.flag, 0x04) do
        0x04 -> Parser.Utils.read_uint32(data)
        _ -> {0, data}
      end

      {rest, %{state | unknown1: value} }
    end

    defp read_member_count({data, state}) do
      {value, rest} = Parser.Utils.read_uint32(data)

      {rest, %{state | member_count: value} }
    end
  end
