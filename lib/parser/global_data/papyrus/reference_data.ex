defmodule Parser.GlobalData.Papyrus.ReferenceData do

  use Bitwise

    def read({data, state}) do
      recall = fn(data) ->

        {rest, filled_state} = read_reference_id({data, %Parser.Structs.GlobalData.ReferenceData{}})
          |> read_flag()
          |> read_type()
          |> read_unknown0()
          |> read_unknown1()
          |> read_member_count()


          {rest1, filled_state1} = Parser.GlobalData.Papyrus.Variable.read({rest, filled_state}, filled_state.member_count)

        {filled_state1, rest1}
      end

      {filled_state, rest} = Parser.Utils.read_structure(
        state.reference_count,
        data,
        recall
      )

      {rest, %{state | reference_data: filled_state}}
    end

    defp read_reference_id({data, state}) do
      {value, rest} = Parser.Utils.read_uint32(data)

      {rest, %{state | reference_id: value} }
    end

    defp read_flag({data, state}) do
      {value, rest} = Parser.Utils.read_uint8(data)

      {rest, %{state | flag: value} }
    end

    defp read_type({data, state}) do
      {value, rest} = Parser.Utils.read_uint16(data)

      {rest, %{state | type: value} }
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
