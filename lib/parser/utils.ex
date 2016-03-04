defmodule Parser.Utils do

	use Bitwise

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

        [track_count, rest_data]
      16 ->
        <<
          byte2::little-integer-size(8),
          rest_of_data::binary
        >> = rest_data
        track_count = (byte1 ||| (byte2 <<< 8)) >>> 2

        [track_count, rest_of_data]
      32 ->
        <<
          byte2::little-integer-size(8),
          byte3::little-integer-size(8),
          rest_of_data::binary
        >> = rest_data
        track_count = ((byte1 ||| (byte2 <<< 8)) ||| (byte3 <<< 16)) >>> 2

        [track_count, rest_of_data]
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

        [track_count, rest_data]
      16 ->
        <<
          byte2::little-integer-size(8),
          rest_of_data::binary
        >> = rest_data
        track_count = (byte1 ||| (byte2 <<< 8)) >>> 2

        [track_count, rest_of_data]
      32 ->
        <<
          byte2::little-integer-size(8),
          byte3::little-integer-size(8),
          rest_of_data::binary
        >> = rest_data
        track_count = ((byte1 ||| (byte2 <<< 8)) ||| (byte3 <<< 16)) >>> 2

        [track_count, rest_of_data]
    end
  end

	def read_uint8(data) do
		read_uint8_data(data)
	end

	defp read_uint8_data(<<value::little-unsigned-integer-size(8)>>) do
		[value, <<>>]
	end

	defp read_uint8_data(
	<<value::little-unsigned-integer-size(8),
		rest::binary>>) do
		[value, rest]
	end

	def read_uint16(data) do
		read_uint16_data(data)
	end

	defp read_uint16_data(<<value::little-unsigned-integer-size(16)>>) do
		[value, <<>>]
	end

	defp read_uint16_data(
	<<value::little-unsigned-integer-size(16),
		rest::binary>>) do
		[value, rest]
	end

	def read_uint32(data) do
		read_uint32_data(data)
	end

	defp read_uint32_data(<<value::little-unsigned-integer-size(32)>>) do
		[value, <<>>]
	end

	defp read_uint32_data(
	<<value::little-unsigned-integer-size(32),
		rest::binary>>) do
		[value, rest]
	end

	def read_refid(data) do
		<<refid::binary-size(3),
			rest::binary
		>> = data

		[refid, rest]
	end

	def read_refid_list(count, data) do
		parse_refid_list(count, data, [])
	end

	defp parse_refid_list(0, data, acc) do
    [acc, data]
  end

  defp parse_refid_list(count, data, acc) do
    [unknown, rest] = Parser.Utils.read_refid(data)

    parse_refid_list(count - 1, rest, acc ++ [unknown])
  end
end
