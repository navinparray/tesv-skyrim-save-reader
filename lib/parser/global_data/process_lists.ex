defmodule Parser.GlobalData.ProcessLists do

	def parse(data) do
    <<
      unknown_1::little-float-size(32),
      unknown_2::little-float-size(32),
      unknown_3::little-float-size(32),
      next_num::little-unsigned-integer-size(32),
      rest::binary
    >> = data

    <<
      count::little-integer-size(8),
      crimes::binary
    >> = rest

    [crime_type_count, crimes_data] = Parser.Utils.read_vs_val(count, crimes)

    [
      unknown_1: unknown_1,
      unknown_2: unknown_2,
      unknown_3: unknown_3,
      next_num: next_num,
      crime_type_count: crime_type_count,
      all_crimes: crimes_data
    ]
	end
end
