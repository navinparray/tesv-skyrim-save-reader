defmodule Parser.GlobalData.SkyCells do

	def parse(data) do
    {sky_cell_count, rest0} = Parser.Utils.read_vsval(data)
    
    %{
      count: sky_cell_count,
      rest: parse_sky_cell_data(rest0, [])
    }
	end

  defp parse_sky_cell_data(<<>>, acc) do
    acc
  end

  defp parse_sky_cell_data(data, acc) do
    <<
      unknown1::binary-size(3),
      unknown2::binary-size(3),
      rest::binary
    >> = data

    record = %{
      unknown1: unknown1, 
      unknown2: unknown2
    }

    parse_sky_cell_data(rest, acc ++ [record])
  end
end
