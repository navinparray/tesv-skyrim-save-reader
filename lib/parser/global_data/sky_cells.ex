defmodule Parser.GlobalData.SkyCells do

	def parse(data) do
    <<
      count::little-integer-size(8),
      rest::binary
    >> = data

    [sky_cell_count, rest_data] = Parser.Utils.read_vs_val(count, rest)
    [
      count: sky_cell_count,
      rest: parse_sky_cell_data(rest_data, [])
    ]
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

    parse_sky_cell_data(rest, acc ++ [[unknown1: unknown1, unknown2: unknown2]])
  end
end
