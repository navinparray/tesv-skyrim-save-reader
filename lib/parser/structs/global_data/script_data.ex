defmodule Parser.Structs.GlobalData.ScriptData do
  @derive [Poison.Encoder]

  defstruct [
    script_id: 0,
    flag: 0,
    script_type: 0,
    unknown0: 0,
    unknown1: 0,
    member_count: 0,
    member: [Parser.Structs.GlobalData.Variable]
  ]
end