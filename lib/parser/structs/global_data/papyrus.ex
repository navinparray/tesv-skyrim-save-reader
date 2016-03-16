defmodule Parser.Structs.GlobalData.Papyrus do
  @derive [Poison.Encoder]

  defstruct [
    header: 0,
    str_count: 0,
    strings: [String],
    script_count: 0,
    script: [Parser.Structs.GlobalData.Script],
    script_instance_count: 0,
    script_instance: [Parser.Structs.GLobalData.ScriptInstance]
  ]
end
