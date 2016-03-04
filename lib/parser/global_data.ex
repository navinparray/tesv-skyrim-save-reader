defmodule Parser.GlobalData do

  def parse(<<>>, acc) do
    acc
  end

  def parse(
    <<
      data_type::little-unsigned-integer-size(32),
      data_length::little-unsigned-integer-size(32),
      data_read::binary-size(data_length),
      rest :: binary
    >>, acc) do

    this_data = parse_global_data_by_type(data_type, data_read)

    parse(rest, acc ++ [{data_type, data_length, this_data}])
  end


  defp parse_global_data_by_type(0, data) do
  	Parser.GlobalData.MiscStats.parse(data)
  end

  defp parse_global_data_by_type(1, data) do
  	Parser.GlobalData.PlayerLocation.parse(data)
  end

  defp parse_global_data_by_type(2, data) do
    Parser.GlobalData.TES.parse(data)
  end

  defp parse_global_data_by_type(3, data) do
    Parser.GlobalData.Variables.parse(data)
  end

  defp parse_global_data_by_type(4, data) do
  	Parser.GlobalData.CreatedObjects.parse(data)
  end

  defp parse_global_data_by_type(5, data) do
    Parser.GlobalData.Effects.parse(data)
  end

  defp parse_global_data_by_type(6, data) do
  	Parser.GlobalData.Weather.parse(data)
  end

  defp parse_global_data_by_type(7, data) do
  	Parser.GlobalData.Audio.parse(data)
  end

  defp parse_global_data_by_type(8, data) do
  	Parser.GlobalData.SkyCells.parse(data)
  end

  defp parse_global_data_by_type(100, data) do
  	Parser.GlobalData.ProcessLists.parse(data)
  end

  defp parse_global_data_by_type(101, data) do
     Parser.GlobalData.Combat.parse(data)
  end

  defp parse_global_data_by_type(102, data) do
    Parser.GlobalData.Interface.parse(data)
  end

  defp parse_global_data_by_type(103, data) do
    Parser.GlobalData.ActorCauses.parse(data)
  end

  @doc """
    no data format is available
  """

  defp parse_global_data_by_type(104, data) do
    data
  end

  defp parse_global_data_by_type(105, data) do
    Parser.GlobalData.DetectionManager.parse(data)
  end

  defp parse_global_data_by_type(106, data) do
    Parser.GlobalData.LocationMetaData.parse(data)
  end

  defp parse_global_data_by_type(107, data) do
    Parser.GlobalData.QuestStaticData.parse(data)
  end

  defp parse_global_data_by_type(108, data) do
    Parser.GlobalData.StoryTeller.parse(data)
  end

  defp parse_global_data_by_type(109, data) do
    Parser.GlobalData.MagicFavorites.parse(data)
  end

  defp parse_global_data_by_type(110, data) do
    Parser.GlobalData.PlayerControls.parse(data)
  end

  defp parse_global_data_by_type(111, data) do
    Parser.GlobalData.StoryEventManager.parse(data)
  end

  defp parse_global_data_by_type(112, data) do
    Parser.GlobalData.IngredientShared.parse(data)
  end

  defp parse_global_data_by_type(113, data) do
    Parser.GlobalData.MenuControls.parse(data)
  end

  defp parse_global_data_by_type(114, data) do
    Parser.GlobalData.MenuTopicManager.parse(data)
  end

  defp parse_global_data_by_type(1000, data) do
    data
  end

  defp parse_global_data_by_type(1001, data) do
    data
  end

  defp parse_global_data_by_type(1002, data) do
    data
  end

  defp parse_global_data_by_type(1003, data) do
    data
  end

  defp parse_global_data_by_type(1004, data) do
    data
  end

  defp parse_global_data_by_type(1005, data) do
    data
  end

  defp parse_global_data_by_type(_, data) do
    data
  end

end
