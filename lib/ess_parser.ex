defmodule ESSParser do


  @doc """
  Convert a savefile to a JSON structure

      iex> ESSParser.decode("Save 3 Saryn Embershard Mine 00.42.13.ess")
      {:ok, "[1,2,3]"}
  """

  @spec decode(String.t()) :: String.t()

  def decode(file_name) do

    {result, content} = get_file_contents(file_name)

    case result do
      :ok ->
        # IO.inspect parse_binary(content)
        parse_binary(content)
        IO.inspect {:ok}
      _ ->
        IO.puts content
    end
  end

  @spec parse_binary(binary()) :: String.t()

  defp parse_binary(binary_content) do
    <<
      magic :: binary-size(13),
      header_size :: little-unsigned-integer-size(32),
      version :: little-unsigned-integer-size(32),
      save_number :: little-unsigned-integer-size(32),
      player_name_size :: little-unsigned-integer-size(16),
      player_name :: binary-size(player_name_size),
      player_level :: little-unsigned-integer-size(32),
      player_location_size :: little-unsigned-integer-size(16),
      player_location :: binary-size(player_location_size),
      game_date_size :: little-unsigned-integer-size(16),
      game_date :: binary-size(game_date_size),
      player_race_editor_id_size :: little-unsigned-integer-size(16),
      player_race_editor_id :: binary-size(player_race_editor_id_size),
      player_sex :: little-unsigned-integer-size(8),
      player_current_experience :: little-float-size(32),
      player_level_up_experience :: little-float-size(32),
      file_time :: binary-size(9),
      shot_width :: little-unsigned-integer-size(32),
      shot_height :: little-unsigned-integer-size(32),
      rest :: binary
    >> = binary_content

    shot_data_size = 3 * shot_width * shot_height
    <<
      _shot_data :: binary-size(shot_data_size),
      form_version :: little-unsigned-integer-size(8),
      plugin_info_size :: little-unsigned-integer-size(32),
      plugin_data :: binary-size(plugin_info_size),
      form_id_array_count_offset :: little-unsigned-integer-size(32),
      unknown_table_3_offset :: little-unsigned-integer-size(32),
      global_data_table_1_offset :: little-unsigned-integer-size(32),
      global_data_table_2_offset :: little-unsigned-integer-size(32),
      change_form_offset :: little-unsigned-integer-size(32),
      global_data_table_3_offset :: little-unsigned-integer-size(32),
      global_data_table_1_count :: little-unsigned-integer-size(32),
      global_data_table_2_count :: little-unsigned-integer-size(32),
      global_data_table_3_count :: little-unsigned-integer-size(32),
      change_form_count :: little-unsigned-integer-size(32),
      unused :: binary-size(60), # 32 * 15
      rest1 :: binary
    >> = rest

    <<
      _plugin_count :: little-unsigned-integer-size(8),
      rest_plugin_data :: binary
    >> = plugin_data
    plugin_list = Parser.PluginInfo.parse(rest_plugin_data, [])

    # Global data table 1
    # length is global_data_table_2_offset -  global_data_table_1_offset

    global_data_table_1_length = global_data_table_2_offset -  global_data_table_1_offset
    global_data_table_2_length = change_form_offset -  global_data_table_2_offset
    change_forms_length = global_data_table_3_offset - change_form_offset
    global_data_table_3_length = form_id_array_count_offset -  global_data_table_3_offset

    <<
      global_data_table_1_data :: binary-size(global_data_table_1_length),
      other_data :: binary
    >> = rest1

    global_data_table_1 = Parser.GlobalData.parse(global_data_table_1_data, [])

    <<
      global_data_table_2_data :: binary-size(global_data_table_2_length),
      other_data :: binary
    >> = other_data

    global_data_table_2 = Parser.GlobalData.parse(global_data_table_2_data, [])

    <<
      chnage_form_data :: binary-size(change_forms_length),
      other_data :: binary
    >> = other_data

    <<
      global_data_table_3_data :: binary-size(global_data_table_3_length),
      other_data :: binary
    >> = other_data

    global_data_table_3 = Parser.GlobalData.parse(global_data_table_3_data, [])

    ess_data = %Parser.Structs.ESSData{
      magic: magic,
      header_size: header_size,
      version: version,
      save_number: save_number,
      player_name_size: player_name_size,
      player_name: player_name,
      player_level: player_level,
      player_location_size: player_location_size,
      player_location: player_location,
      game_date_size: game_date_size,
      game_date: game_date,
      player_race_editor_id_size: player_race_editor_id_size,
      player_race_editor_id: player_race_editor_id,
      player_sex: player_sex,
      player_current_experience: player_current_experience,
      player_level_up_experience: player_level_up_experience,
      file_time: file_time,
      shot_width: shot_width,
      shot_height: shot_height,
      form_version: form_version,
      plugin_info_size: plugin_info_size,
      plugin_data: plugin_list,
      form_id_array_count_offset: form_id_array_count_offset,
      unknown_table_3_offset: unknown_table_3_offset,
      global_data_table_1_offset: global_data_table_1_offset,
      global_data_table_2_offset: global_data_table_2_offset,
      change_form_offset: change_form_offset,
      global_data_table_3_offset: global_data_table_3_offset,
      global_data_table_1_count: global_data_table_1_count,
      global_data_table_2_count: global_data_table_2_count,
      global_data_table_3_count: global_data_table_3_count,
      change_form_count: change_form_count,
      unused: unused,
      global_data_table_1: global_data_table_1,
      global_data_table_2: global_data_table_2,
      global_data_table_3: global_data_table_3
    }

    # Parser.Utils.write_to_file(global_data_table_3)
  end

  defp get_file_contents(file_name) do
    case File.read(file_name) do
      {:ok, binary} ->
        {:ok, binary}
      _ ->
        {:error, "Could not read the file: #{file_name}"}
    end
  end
end
