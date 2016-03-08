defmodule Parser.Utils do

	use Bitwise

	@doc """
		Perform a recursion on some data using an accumulator

		It takes a function that will read a record and return the record and any extra data_type

		ex.

		data_reader = fn data ->
			<<unknown0::little-unsigned-integer-size(32),
				unknown1::little-unsigned-integer-size(16),
				rest::binary
			>> = data

			record = [
				unknown0: unknown0,
				unknown1: unknown1
			]

			[record, rest]

		end

		read_structure(5, data, data_reader)

	"""
  def read_structure(count, data, fun) do

    read_record(count, data, fun, [])
  end

  defp read_record(0, data, _, acc) do
    {acc, data}
  end

  defp read_record(count, data, fun, acc) do
    {record, rest} = fun.(data)

    read_record(count - 1, rest, fun, acc ++ [record])
  end

  def read_vsval_list(count, data) do
    parse_vsval_list(count, data, [])
  end

  defp parse_vsval_list(0, data, acc) do
    {acc, data}
  end

  defp parse_vsval_list(count, data, acc) do
    {item, rest} = read_vsval(data)

    parse_vsval_list(count - 1, rest, acc ++ [item])
  end  

	def read_vsval(data) do

		<<byte1::little-integer-size(8),
			rest_data::binary
		>> = data

		track_count_size =
      cond do
        band(byte1,0b00000001) == 0b00000000 -> 8
        band(byte1,0b00000001) == 0b00000001 -> 16
        band(byte1,0b00000010) == 0b00000010 -> 32
      end

    # <<track_count_data::little-integer-size(track_count_size)>> = <<byte1>>

    case track_count_size do
      8 ->
        track_count = byte1 >>> 2

        {track_count, rest_data}
      16 ->
        <<
          byte2::little-integer-size(8),
          rest_of_data::binary
        >> = rest_data
        track_count = (byte1 ||| (byte2 <<< 8)) >>> 2

        {track_count, rest_of_data}
      32 ->
        <<
          byte2::little-integer-size(8),
          byte3::little-integer-size(8),
          rest_of_data::binary
        >> = rest_data
        track_count = ((byte1 ||| (byte2 <<< 8)) ||| (byte3 <<< 16)) >>> 2

        {track_count, rest_of_data}
    end
	end

  def read_vs_val(byte1, rest_data)  do

    track_count_size =
      cond do
        band(byte1,0b00000001) == 0b00000000 -> 8
        band(byte1,0b00000001) == 0b00000001 -> 16
        band(byte1,0b00000010) == 0b00000010 -> 32
      end

    # <<track_count_data::little-integer-size(track_count_size)>> = <<byte1>>

    case track_count_size do
      8 ->
        track_count = byte1 >>> 2

        {track_count, rest_data}
      16 ->
        <<
          byte2::little-integer-size(8),
          rest_of_data::binary
        >> = rest_data
        track_count = (byte1 ||| (byte2 <<< 8)) >>> 2

        {track_count, rest_of_data}
      32 ->
        <<
          byte2::little-integer-size(8),
          byte3::little-integer-size(8),
          rest_of_data::binary
        >> = rest_data
        track_count = ((byte1 ||| (byte2 <<< 8)) ||| (byte3 <<< 16)) >>> 2

        {track_count, rest_of_data}
    end
  end

	def read_uint8_list(count, data) do
		parse_uint8_list(count, data, [])
	end

	defp parse_uint8_list(0, data, acc) do
		{acc, data}
	end

	defp parse_uint8_list(count, data, acc) do
		{item, rest} = read_uint8(data)

		parse_uint8_list(count - 1, rest, acc ++ [item])
	end

	def read_uint8(data) do
		read_uint8_data(data)
	end

	defp read_uint8_data(<<value::little-unsigned-integer-size(8)>>) do
		{value, <<>>}
	end

	defp read_uint8_data(
		<<value::little-unsigned-integer-size(8),
		rest::binary>>) do
		{value, rest}
	end

	def read_uint16_list(count, data) do
		parse_uint16_list(count, data, [])
	end

	defp parse_uint16_list(0, data, acc) do
		{acc, data}
	end

	defp parse_uint16_list(count, data, acc) do
		{item, rest} = read_uint16(data)

		parse_uint16_list(count - 1, rest, acc ++ [item])
	end

	def read_uint16(data) do
		read_uint16_data(data)
	end

	defp read_uint16_data(<<value::little-unsigned-integer-size(16)>>) do
		{value, <<>>}
	end

	defp read_uint16_data(
		<<value::little-unsigned-integer-size(16),
		rest::binary>>) do
		{value, rest}
	end

	def read_uint32_list(count, data) do
		parse_uint32_list(count, data, [])
	end

	defp parse_uint32_list(0, data, acc) do
		{acc, data}
	end

	defp parse_uint32_list(count, data, acc) do
		{item, rest} = read_uint32(data)

		parse_uint32_list(count - 1, rest, acc ++ [item])
	end

	def read_uint32(data) do
		read_uint32_data(data)
	end

	defp read_uint32_data(<<value::little-unsigned-integer-size(32)>>) do
		{value, <<>>}
	end

	defp read_uint32_data(
		<<value::little-unsigned-integer-size(32),
		rest::binary>>) do
		{value, rest}
	end

	def read_float_list(count, data) do
		parse_float_list(count, data, [])
	end

	defp parse_float_list(0, data, acc) do
		{acc, data}
	end

	defp parse_float_list(count, data, acc) do
		{item, rest} = read_float(data)

		parse_float_list(count - 1, rest, acc ++ [item])
	end

	def read_float(data) do
		read_float_data(data)
	end

	defp read_float_data(<<value::little-float-size(32)>>) do
		{value, <<>>}
	end

	defp read_float_data(
		<<value::little-float-size(32),
		rest::binary>>) do
		{value, rest}
	end

	def read_refid(data) do
		read_refid_data(data)
	end

	defp read_refid_data(<<refid::binary-size(3)>>) do
		{refid, <<>>}
	end

	defp read_refid_data(data) do
		<<refid::binary-size(3),
			rest::binary
		>> = data

		{refid, rest}
	end

	def read_refid_list(count, data) do
		parse_refid_list(count, data, [])
	end

	defp parse_refid_list(0, data, acc) do
    {acc, data}
  end

  defp parse_refid_list(count, data, acc) do
    {unknown, rest} = Parser.Utils.read_refid(data)

    parse_refid_list(count - 1, rest, acc ++ [unknown])
  end

	def read_wstring(data) do
		<<wstring_size :: little-unsigned-integer-size(16),
      wstring :: binary-size(wstring_size),
			rest::binary
		>> = data

		{wstring, rest}
	end

	def read_wstring_list(count, data) do
		parse_wstring_list(count, data, [])
	end

	defp parse_wstring_list(0, data, acc) do
    {acc, data}
  end

  defp parse_wstring_list(count, data, acc) do
    {unknown, rest} = Parser.Utils.read_wstring(data)

    parse_wstring_list(count - 1, rest, acc ++ [unknown])
  end

  def read_binary(count, data) do
    <<bin::binary-size(count),
      rest::binary>> = data

    {bin, rest}
  end

  def read_sint16_list(count, data) do
    parse_sint16_list(count, data, [])
  end

  defp parse_sint16_list(0, data, acc) do
    {acc, data}
  end

  defp parse_sint16_list(count, data, acc) do
    {item, rest} = read_sint16(data)

    parse_sint16_list(count - 1, rest, acc ++ [item])
  end

  def read_sint16(data) do
    read_sint16_data(data)
  end

  defp read_sint16_data(<<value::little-integer-size(16)>>) do
    {value, <<>>}
  end

  defp read_sint16_data(
    <<value::little-integer-size(16),
    rest::binary>>) do
    {value, rest}
  end
end
