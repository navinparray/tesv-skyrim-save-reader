defmodule Parser.Structs.ESSData do
	@derive [Poison.Encoder]

  defstruct [
    magic: nil,
    header_size: nil,
    version: nil,
    save_number: nil,
    player_name_size: nil,
    player_name: nil,
    player_level: nil,
    player_location_size: nil,
    player_location: nil,
    game_date_size: nil,
    game_date: nil,
    player_race_editor_id_size: nil,
    player_race_editor_id: nil,
    player_sex: nil,
    player_current_experience: nil,
    player_level_up_experience: nil,
    file_time: nil,
    shot_width: nil,
    shot_height: nil,
    form_version: nil,
    plugin_info_size: nil,
    plugin_data: [],
    form_id_array_count_offset: nil,
    unknown_table_3_offset: nil,
    global_data_table_1_offset: nil,
    global_data_table_2_offset: nil,
    change_form_offset: nil,
    global_data_table_3_offset: nil,
    global_data_table_1_count: nil,
    global_data_table_2_count: nil,
    global_data_table_3_count: nil,
    change_form_count: nil,
    unused: nil,
    global_data_table_1: [],
    global_data_table_2: [],
    change_forms: [],
    global_data_table_3: [],
    form_id_array: [],
    visited_worldspace_array: [],
    unknown_table_3: []
  ]

end
