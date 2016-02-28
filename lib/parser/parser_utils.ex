defmodule ParserUtils do
	
	use Bitwise

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
end