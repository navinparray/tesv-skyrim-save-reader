defmodule Parser.GlobalData.Audio do
	def parse(data) do

		{unknown, rest} = Parser.Utils.read_refid(data)

		{tracks_count, rest1} = Parser.Utils.read_vsval(rest)

		track_count_size = tracks_count * 3

    <<
      tracks::binary-size(track_count_size),
      background_music::binary-size(3)
    >> = rest1

    %{
      unknown: unknown,
      tracks_count: tracks_count,
      tracks: tracks,
      background_music: background_music
    }
	end
end
