defmodule Parser.GlobalData.ProcessLists do

	def parse(data) do
    <<
      unknown_1::little-float-size(32),
      unknown_2::little-float-size(32),
      unknown_3::little-float-size(32),
      next_num::little-unsigned-integer-size(32),
      rest0::binary
    >> = data

    {crime_type_count, rest1} = Parser.Utils.read_vsval(rest0)

    %{
      unknown_1: unknown_1,
      unknown_2: unknown_2,
      unknown_3: unknown_3,
      next_num: next_num,
      crime_type_count: crime_type_count,
      all_crimes: rest1
    }
	end
end
