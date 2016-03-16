defmodule Parser.Structs.GlobalData.Papyrus do
  @derive [Poison.Encoder]

  defstruct [
    header: 0,
    str_count: 0,
    strings: [String],
    script_count: 0,
    script: [Parser.Structs.GlobalData.Script],
    script_instance_count: 0,
    script_instance: [Parser.Structs.GLobalData.ScriptInstance],
    reference_count: 0,
    reference: [Parser.Structs.GLobalData.References],
    array_info_count: 0,
    array_info: [Parser.Structs.GlobalData.ArrayInfo],
    papyrus_runtime: 0,
    active_script_count: 0,
    active_script: [Parser.Structs.GlobalData.ActiveScript],
    script_data: [Parser.Structs.GlobalData.ScriptData],
    reference_data: [Parser.Structs.GlobalData.ReferenceData],
    array_data: [Parser.Structs.GlobalData.ArrayData]
  ]
end
