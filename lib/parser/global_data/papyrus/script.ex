defmodule Parser.GlobalData.Papyrus.Script do

  def read_script({data, state}) do

    recall = fn(data) ->

      empty_state = %Parser.Structs.GlobalData.Script{}

      {rest, filled_state} = read_script_name({data, empty_state})
        |> read_script_type()
        |> read_member_count()
        |> read_member_data()

      {filled_state, rest}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.script_count,
      data,
      recall
    )

    {rest, %{state | script: filled_state}}
  end

  defp read_script_name({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    { rest, %{state | script_name: value} }
  end

  defp read_script_type ({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    { rest, %{state | script_type: value} }
  end

  defp read_member_count({data, state}) do
    {value, rest} = Parser.Utils.read_uint32(data)

    { rest, %{state | member_count: value} }
  end

  defp read_member_data ({data, state}) do

    recall = fn (data) ->

      empty_state = %Parser.Structs.GlobalData.MemberData{}

      {rest, filled_state} = read_member_name({data, empty_state})
        |> read_member_type()

      {filled_state, rest}
    end

    {filled_state, rest} = Parser.Utils.read_structure(
      state.member_count,
      data,
      recall
    )

    {rest, %{state | member_data: filled_state}}
  end

  defp read_member_name({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    { rest, %{state | member_name: value} }
  end

  defp read_member_type({data, state}) do
    {value, rest} = Parser.Utils.read_uint16(data)

    { rest, %{state | member_type: value} }
  end
end
