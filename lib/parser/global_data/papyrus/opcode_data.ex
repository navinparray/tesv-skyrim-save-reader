defmodule Parser.GlobalData.Papyrus.OpcodeData do

  def read({data, state}) do
    recall = fn(data) ->

      {rest, filled_state} = read_opcode({data, %Parser.Structs.GlobalData.OpcodeData{}})
        |> read_opcode_parameter()

      {filled_state, rest}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.function_locals_count,
      data,
      recall
    )

    {rest, %{state | function_locals: filled_state}}
  end

  defp read_opcode({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    {rest, %{state | opcode: value} }
  end

  defp read_opcode_parameter({data, state}) do
    case state.opcode do
      0x00 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, [])
      0x01 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'I', 'I'])
      0x02 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'F', 'F'])
      0x03 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'I', 'I'])
      0x04 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'F', 'F'])
      0x05 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'I', 'I'])
      0x06 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'F', 'F'])
      0x07 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'I', 'I'])
      0x08 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'F', 'F'])
      0x09 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'I', 'I'])
      0x0a -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'A'])
      0x0b -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'I'])
      0x0c -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'F'])
      0x0d -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'A'])
      0x0e -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'A'])
      0x0f -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'A', 'A'])
      0x10 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'A', 'A'])
      0x11 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'A', 'A'])
      0x12 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'A', 'A'])
      0x13 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'A', 'A'])
      0x14 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['L'])
      0x15 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['A', 'L'])
      0x16 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['A', 'L'])
      0x17 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['N', 'S', 'S', '*'])
      0x18 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['N', 'S', '*'])
      0x19 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['N', 'N', 'S', '*'])
      0x1a -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['A'])
      0x1b -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'Q', 'Q'])
      0x1c -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['N', 'S', 'S'])
      0x1d -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['N', 'S', 'A'])
      0x1e -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'U'])
      0x1f -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'S'])
      0x20 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'S', 'I'])
      0x21 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'I', 'A'])
      0x22 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'S', 'A', 'I'])
      0x23 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, ['S', 'S', 'A', 'I'])
      0x24 -> Parser.GlobalData.Papyrus.Parameter.read({data, state}, [])
    end
  end
end
