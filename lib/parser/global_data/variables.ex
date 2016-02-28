defmodule Parser.GlobalData.Variables do
	

	def parse(data) do
    <<
      count::little-integer-size(16),
      rest::binary
    >> = data
    
    [count: count, rest: parse_global_variables(rest, [])]		
	end

  defp parse_global_variables(<<>>, acc) do
    acc
  end

  defp parse_global_variables(<<
      form_id::binary-size(3),
      value::little-float-size(32),
      rest::binary
    >>, acc) do
    parse_global_variables(rest, acc++ [[form_id: Base.encode16(form_id), value: value]])
  end	
end