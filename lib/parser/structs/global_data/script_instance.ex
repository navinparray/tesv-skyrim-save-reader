defmodule Parser.Structs.GLobalData.ScriptInstance do
  @derive {Poison.Encoder, except: [:ref_id]}

  defstruct [
    script_id: 0,
    script_name: 0,
    unknown2bits: 0,
    unknown0: 0,
    ref_id: 0,
    unknown1: 0
  ]
end
