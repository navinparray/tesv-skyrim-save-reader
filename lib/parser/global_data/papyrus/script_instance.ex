defmodule Parser.GlobalData.Papyrus.ScriptInstance do

  def read({data, state}) do

    recall = fn(data) ->

      {rest, filled_state} = read_script_id({data, %Parser.Structs.GLobalData.ScriptInstance{}})
        |> read_script_name()
        |> read_unknown2bits()
        |> read_unknown0()
        |> read_ref_id()
        |> read_unknown1()

      {filled_state, rest}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.script_instance_count,
      data,
      recall
    )

    {rest, %{state | script_instance: filled_state}}
  end

  defp read_script_id({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    { rest, %{state | script_id: value} }
  end

  defp read_script_name({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    { rest, %{state | script_name: value} }
  end

  defp read_unknown2bits({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    { rest, %{state | unknown2bits: value} }
  end

  defp read_unknown0({data, state}) do
    {value, rest} = Parser.Utils.read_sint16(data)

    { rest, %{state | unknown0: value} }
  end

  defp read_ref_id({data, state}) do
    {value, rest} = Parser.Utils.read_refid(data)

    { rest, %{state | ref_id: value} }
  end

  defp read_unknown1({data, state}) do
    {value, rest} = Parser.Utils.read_uint8(data)

    { rest, %{state | unknown1: value} }
  end
end
