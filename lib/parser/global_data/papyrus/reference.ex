defmodule Parser.GlobalData.Papyrus.Reference do


  def read({data, state}) do
    recall = fn(data) ->

      {rest, filled_state} = read_reference_id({data, %Parser.Structs.GLobalData.References{}})
        |> read_type()

      {filled_state, rest}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.reference_count,
      data,
      recall
    )

    {rest, %{state | reference: filled_state}}
  end

  defp read_reference_id({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    { rest, %{state | reference_id: value} }
  end

  defp read_type({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    { rest, %{state | type: value} }
  end

end
