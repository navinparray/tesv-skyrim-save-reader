defmodule Parser.GlobalData.Papyrus.ArrayData do

  def read({data, state}) do
    recall = fn(data) ->

      {rest, filled_state} = read_array_id({data, %Parser.Structs.GlobalData.ArrayData{}})

      [array_info_record | _] = Enum.filter state.array_info, fn(v) ->
        v.array_id == filled_state.array_id
      end

      {rest1, filled_state1} = Parser.GlobalData.Papyrus.Variable.read({rest, filled_state}, array_info_record.length)

      {filled_state1, rest1}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.array_info_count,
      data,
      recall
    )

    {rest, %{state | array_data: filled_state}}
  end

  defp read_array_id({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | array_id: value} }
  end
end
