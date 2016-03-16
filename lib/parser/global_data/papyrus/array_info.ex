defmodule Parser.GlobalData.Papyrus.ArrayInfo do

  def read({data, state}) do
    recall = fn(data) ->

      {rest, filled_state} = read_array_id({data, %Parser.Structs.GlobalData.ArrayInfo{}})
        |> read_type()
        |> read_ref_type()
        |> read_length()

      {filled_state, rest}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.array_info_count,
      data,
      recall
    )
    {rest, %{state | array_info: filled_state}}
  end

  defp read_array_id({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | array_id: value} }
  end

  defp read_type({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    {rest, %{state | type: value} }
  end

  defp read_ref_type({data, state}) do

    {value, rest} = case state.type do
      1 -> Parser.Utils.read_uint16(data)
      _ -> {0, data}
    end

    {rest, %{state | ref_type: value} }
  end

  defp read_length({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | length: value} }
  end
end
