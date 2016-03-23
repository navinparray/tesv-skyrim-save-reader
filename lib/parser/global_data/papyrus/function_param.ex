defmodule Parser.GlobalData.Papyrus.FunctionParam do

  def read({data, state}) do
    recall = fn(data) ->

      {rest, filled_state} = read_param_name({data, %Parser.Structs.GlobalData.FunctionParam{}})
        |> read_param_type()

      {filled_state, rest}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.function_parameter_count,
      data,
      recall
    )

    {rest, %{state | function_params: filled_state}}
  end

  defp read_param_name({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | param_name: value} }
  end

  defp read_param_type({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    {rest, %{state | param_type: value} }
  end
end
