defmodule Parser.PluginInfo do
	@moduledoc """
	Functions for parsing binary data into it's  constituent parts.

	See http://www.uesp.net/wiki/Tes5Mod:Save_File_Format for more details on the format.

	Plugin Info Data

	pluginCount							uint8
	plugins									wstring[pluginCount]
	"""

	@doc """
		Recursively extract each plugin name and return a listing
	"""

	# When there are no more plugin names return the listing

	@spec parse(binary(), list()) :: list()

  def parse(<<>>, acc) do
    acc
  end  

  # Use pattern match to extract the string size from the data

	@spec parse(binary(), list()) :: list()
  
  def parse(
    << string_size::little-integer-size(16), other_binary_data :: binary>>, 
    acc) do

  	# the string_size is used to separate the plugin name from the rest of the data
    << 
      plugin_name :: binary-size(string_size),
      rest :: binary 
    >> = other_binary_data

    parse(rest, acc ++ [plugin_name])
  end	
end