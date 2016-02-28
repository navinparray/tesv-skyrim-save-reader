defmodule Parser.GlobalData.MiscStats do


	def parse(data) do
    <<
      count::little-unsigned-integer-size(32),
      rest::binary
    >> = data
    [
      count: count,
      stats: parse_stats(rest, [])
    ]
	end


  defp parse_stats(<<>>, acc) do
    acc
  end  

  defp parse_stats(
    <<
      string_size::little-unsigned-integer-size(16),
      name::binary-size(string_size),
      category::little-unsigned-integer-size(8),
      value::little-integer-size(32),
      rest::binary
    >>, acc) do
    parse_stats(rest, acc ++ [[name: name,category: category,value: value]])
  end   	
end