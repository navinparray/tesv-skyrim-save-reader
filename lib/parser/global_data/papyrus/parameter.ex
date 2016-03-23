defmodule Parser.GlobalData.Papyrus.Parameter do

  def read({data, state}, param_list) do
    {rest, filled_state} = read_opcode_parameter(data, param_list)

    {rest, %{state | param: filled_state}}
  end

  defp read_opcode_parameter(code, data) do
    case code do
      0x00 -> read_opcode_params(data, [])
      0x01 -> read_opcode_params(data, ['S', 'I', 'I'])
      0x02 -> read_opcode_params(data, ['S', 'F', 'F'])
      0x03 -> read_opcode_params(data, ['S', 'I', 'I'])
      0x04 -> read_opcode_params(data, ['S', 'F', 'F'])
      0x05 -> read_opcode_params(data, ['S', 'I', 'I'])
      0x06 -> read_opcode_params(data, ['S', 'F', 'F'])
      0x07 -> read_opcode_params(data, ['S', 'I', 'I'])
      0x08 -> read_opcode_params(data, ['S', 'F', 'F'])
      0x09 -> read_opcode_params(data, ['S', 'I', 'I'])
      0x0a -> read_opcode_params(data, ['S', 'A'])
      0x0b -> read_opcode_params(data, ['S', 'I'])
      0x0c -> read_opcode_params(data, ['S', 'F'])
      0x0d -> read_opcode_params(data, ['S', 'A'])
      0x0e -> read_opcode_params(data, ['S', 'A'])
      0x0f -> read_opcode_params(data, ['S', 'A', 'A'])
      0x10 -> read_opcode_params(data, ['S', 'A', 'A'])
      0x11 -> read_opcode_params(data, ['S', 'A', 'A'])
      0x12 -> read_opcode_params(data, ['S', 'A', 'A'])
      0x13 -> read_opcode_params(data, ['S', 'A', 'A'])
      0x14 -> read_opcode_params(data, ['L'])
      0x15 -> read_opcode_params(data, ['A', 'L'])
      0x16 -> read_opcode_params(data, ['A', 'L'])
      0x17 -> read_opcode_params(data, ['N', 'S', 'S', '*'])
      0x18 -> read_opcode_params(data, ['N', 'S', '*'])
      0x19 -> read_opcode_params(data, ['N', 'N', 'S', '*'])
      0x1a -> read_opcode_params(data, ['A'])
      0x1b -> read_opcode_params(data, ['S', 'Q', 'Q'])
      0x1c -> read_opcode_params(data, ['N', 'S', 'S'])
      0x1d -> read_opcode_params(data, ['N', 'S', 'A'])
      0x1e -> read_opcode_params(data, ['S', 'U'])
      0x1f -> read_opcode_params(data, ['S', 'S'])
      0x20 -> read_opcode_params(data, ['S', 'S', 'I'])
      0x21 -> read_opcode_params(data, ['S', 'I', 'A'])
      0x22 -> read_opcode_params(data, ['S', 'S', 'A', 'I'])
      0x23 -> read_opcode_params(data, ['S', 'S', 'A', 'I'])
      0x24 -> read_opcode_params(data, [])
    end
  end

  defp read_opcode_params(data, []) do
    {{}, data}
  end

  defp read_opcode_params(data, param_type_listing) do

    get_params = fn (el) ->
      case el do
        '*' -> fn ->
          {extra_param_count, rest0} = Parser.Utils.read_uint32(data)
          read_parameter_structure(extra_param_count, rest0)
        end
        _ -> read_parameter_structure(1, data)
      end
    end

    Enum.map(param_type_listing, get_params)
  end

  defp read_parameter_structure(count, data) do

    read_parameter_record(count, data, [])
  end

  defp read_parameter_record(0, data, acc) do
    {acc, data}
  end

  defp read_parameter_record(count, data, acc) do
    {param_type, rest0} = Parser.Utils.read_uint8(data)

    {param_data, rest1} = case param_type do
      x when x in [1,2] -> Parser.Utils.read_uint16(rest0)
      3 -> Parser.Utils.read_uint32(rest0)
      4 -> Parser.Utils.read_float(rest0)
      5 -> Parser.Utils.read_uint8(rest0)
    end

    record = %Parser.Structs.GlobalData.Parameter{
      param_type: param_type,
      param_data: param_data
    }

    read_parameter_record(count - 1, rest1, acc ++ [record])
  end
end
