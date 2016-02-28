defmodule Parser.GlobalData.CreatedObjects do
	
	def parse(data) do
    case data do      
      <<
        weapon_count :: little-integer-size(16),
        weapon_ench_table :: binary-size(weapon_count),
        armour_count :: little-integer-size(16),
        armour_ench_table :: binary-size(armour_count),
        potion_count :: little-integer-size(16),
        potion_table :: binary-size(potion_count),
        poison_count :: little-integer-size(16),
        poison_table :: binary-size(poison_count)      
      >> ->
      [
        weapon_count: weapon_count,
        weapon_ench_table: weapon_ench_table,
        armour_count: armour_count,
        armour_ench_table: armour_ench_table,
        potion_count: potion_count,
        potion_table: potion_table,
        poison_count: poison_count,
        poison_table: poison_table
      ]
       _ ->
        [
          weapon_count: 0,
          weapon_ench_table: [],
          armour_count: 0,
          armour_ench_table: [],
          potion_count: 0,
          potion_table: [],
          poison_count: 0,
          poison_table: []
        ]  
      end   		
	end
end