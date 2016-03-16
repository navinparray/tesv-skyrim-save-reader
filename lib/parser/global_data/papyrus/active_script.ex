defmodule Parser.GlobalData.Papyrus.ActiveScript do

  def read({data, state}) do
    recall = fn(data) ->

      {rest, filled_state} = read_script_id({data, %Parser.Structs.GlobalData.ActiveScript{}})
        |> read_type()

      {filled_state, rest}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.active_script_count,
      data,
      recall
    )

    {rest, %{state | active_script: filled_state}}
  end

  defp read_script_id({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    {rest, %{state | script_id: value} }
  end

  defp read_type({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    {rest, %{state | script_type: value} }
  end
end
