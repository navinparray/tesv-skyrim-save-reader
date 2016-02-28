defmodule Parser.GlobalData.PlayerLocation do
	
	def parse(data) do
    <<
      next_object_id::little-integer-size(32),
      world_space_1::little-integer-size(24),
      coor_x::little-integer-size(32),
      coor_y::little-integer-size(32),
      world_space_2::little-integer-size(24),
      pos_x::little-float-size(32),
      pos_y::little-float-size(32),
      pos_z::little-float-size(32),
      unknown::little-integer-size(8),
      _::binary
    >> = data
    [
      next_object_id: next_object_id,
      world_space_1: world_space_1,
      coor_x: coor_x,
      coor_y: coor_y,
      world_space_2: world_space_2,
      pos_x: pos_x,
      pos_y: pos_y,
      pos_z: pos_z,
      unknown: unknown
    ]		
	end
end