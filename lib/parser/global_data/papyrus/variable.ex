defmodule Parser.GlobalData.Papyrus.Variable do

    def read({data, state}, count) do
      recall = fn(data) ->

        {rest, filled_state} = read_type({data, %Parser.Structs.GlobalData.Variable{}})

        {rest1, filled_state1} = read_data({rest, filled_state})


        {filled_state1, rest1}
      end

      {filled_state, rest} = Parser.Utils.read_structure(
        count,
        data,
        recall
      )

      {rest, %{state | member: filled_state}}
    end

    defp read_type({data, state}) do
      {value, rest} = Parser.Utils.read_uint8(data)

      {rest, %{state | type: value} }
    end

    defp read_data({data, state}) do
      {value, rest} = case state.type do
        x when x in [0,3,4,5,12,13,14,15] -> Parser.Utils.read_binary(4, data)
        x when x in [1,11] -> Parser.Utils.read_binary(6, data)
        2 -> Parser.Utils.read_binary(2, data)
        _ -> {[], data}
      end

      {rest, %{state | data: value}}

    end

  end


  # defp read_variable_data_structure(type, data) do
  #
  #   {value, rest} = case type do
  #     x when x in [0,3,4,5,12,13,14,15] -> Parser.Utils.read_binary(4, data)
  #     x when x in [1,11] -> Parser.Utils.read_binary(6, data)
  #     2 -> Parser.Utils.read_binary(2, data)
  #     _ -> {[], data}
  #   end
  #
  #   {
  #     Parser.Utils.convert_to_list(value),
  #     rest
  #   }
  # end
