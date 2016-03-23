defmodule Parser.GlobalData.Papyrus.FunctionLocal do

  def read({data, state}) do
    recall = fn(data) ->

      {rest, filled_state} = read_local_name({data, %Parser.Structs.GlobalData.FunctionLocal{}})
        |> read_local_type()

      {filled_state, rest}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.function_locals_count,
      data,
      recall
    )

    {rest, %{state | function_locals: filled_state}}
  end

  defp read_local_name({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | local_name: value} }
  end

  defp read_local_type({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | local_type: value} }
  end
end
