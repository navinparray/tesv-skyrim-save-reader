defmodule Parser.GlobalData.Effects do
	@moduledoc """
		parse data for Effects section of the global data

		format of section is taken from here http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Effects
	"""
	
	def parse(data) do

		# extract the first byte which contains a count of type vsval
		<<
			count::little-integer-size(8),
			rest::binary
		>> = data

		[image_spacemodifier_count, image_spacemodifiers_data] = ParserUtils.read_vs_val(count, rest)


		# 'image_spacemodifiers_data' now contains a listing of 'count' effects and two unknown fields of type float

		# the size of each effect is 15 bytes
		effects_data_size = count * 15


		<<
			image_spacemodifiers_efects_data::binary-size(effects_data_size),
			unknown_1::little-float-size(32),
			unknown_2::little-float-size(32)
		>> = image_spacemodifiers_data

		[
			count: count,
			image_space_modifiers: extract_effects(image_spacemodifiers_efects_data),
			unkwon_1: unknown_1,
			unkwon_2: unknown_2
		]
	end

	@doc """
		Each effect consists of
			strength (float)
			timestamp (float)
			unknown (uint32)
			effect RefId (uint8 * 3)
	"""
	
	@spec extract_effects(binary()) :: []

	defp extract_effects(data) do
		
		parse_effects(data, [])
	end

	defp parse_effects(<<>>, acc) do
		acc
	end

	defp parse_effects(<<
			strength::little-float-size(32),
			timestamp::little-float-size(32),
			unknown::little-unsigned-integer-size(32),
			effect_id::binary-size(3),
			rest::binary
		>>, acc
	) do
		data_struct = [
			strength: strength,
			timestamp: timestamp,
			unknown: unknown,
			effect_id: effect_id
		]
		parse_effects(rest, acc ++ [data_struct])
	end
end