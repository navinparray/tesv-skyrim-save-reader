defmodule Parser.Structs.GlobalData.ReferenceData do
  @derive [Poison.Encoder]

  defstruct [
    reference_id: 0,
    flag: 0,
    type: 0,
    unknown0: 0,
    unknown1: 0,
    member_count: 0,
    member: [Parser.Structs.GlobalData.Variable]
  ]
end