defmodule Parser.GlobalData.IngredientShared do
  @moduledoc """
    parse data for ingredient shared section of global data table

    format for section is taken from here - http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Ingredient_Shared

    format of the structure is (Variable Sized)

    count                       vsval
    ingredients_combined        IngredientsCombined[count]

    IngredientsCombined structure

    ingredient0                 RefId
    ingredient1                 RefId

  """

  def parse(data) do

    [count, rest] = Parser.Utils.read_uint32(data)

    [ingredients_combined, _] = read_ingredients_combined_data(count, rest)

    [
      count: count,
      ingredients_combined: ingredients_combined
    ]
  end

  defp read_ingredients_combined_data(count, data) do

    read_ingredients_combined_record(count, data, [])
  end

  defp read_ingredients_combined_record(0, data, acc) do
    [acc, data]
  end

  defp read_ingredients_combined_record(count, data, acc) do
    [ingredient0,rest] = Parser.Utils.read_refid(data)
    [ingredient1,rest1] = Parser.Utils.read_refid(rest)

    read_ingredients_combined_record(count - 1, rest1, acc ++ [ingredient0, ingredient1])
  end
end
