defmodule Parser.GlobalData.Audio do
	def parse(data) do
	    <<
	      unknown::binary-size(3),
	      track_count_vs_val::little-integer-size(8),
	      rest::binary
	    >> = data

	    [tracks_count, rest_data] = Parser.Utils.read_vs_val(track_count_vs_val, rest)

	    track_count_size = tracks_count * 3
	    <<
	      tracks::binary-size(track_count_size),
	      background_music::binary-size(3)
	    >> = rest_data

	    [
	      unknown: unknown,
	      tracks_count: tracks_count,
	      tracks: tracks,
	      background_music: background_music
	    ]
	end
end
