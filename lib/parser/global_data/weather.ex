defmodule Parser.GlobalData.Weather do
	
	def parse(data) do
    <<
      climate::binary-size(3),
      weather::binary-size(3),
      prev_weather::binary-size(3),
      unknown_weather_1::binary-size(3),
      unknown_weather_2::binary-size(3),
      region_weather::binary-size(3),
      current_time::little-float-size(32),
      begin_time::little-float-size(32),
      weather_percentage::little-float-size(32),
      unknown_1::little-integer-size(32),
      unknown_2::little-integer-size(32),
      unknown_3::little-integer-size(32),
      unknown_4::little-integer-size(32),
      unknown_5::little-integer-size(32),
      unknown_6::little-integer-size(32),
      unknown_7::little-float-size(32),
      unknown_8::little-integer-size(32),
      flags::little-integer-size(8),
      rest::binary
    >> = data

    [
      climate: climate,
      weather: weather,
      prev_weather: prev_weather,
      unknown_weather_1: unknown_weather_1,
      unknown_weather_2: unknown_weather_2,
      region_weather: region_weather,
      current_time: current_time,
      begin_time: begin_time,
      weather_percentage: weather_percentage,
      unknown_1: unknown_1,
      unknown_2: unknown_2,
      unknown_3: unknown_3,
      unknown_4: unknown_4,
      unknown_5: unknown_5,
      unknown_6: unknown_6,
      unknown_7: unknown_7,
      unknown_8: unknown_8,
      flags: flags,
      rest: rest
    ]		
	end
end