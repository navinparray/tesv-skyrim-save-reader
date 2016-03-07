defmodule Parser.Structs.GlobalData.ArrayData do
  @derive [Poison.Encoder]

  defstruct [
    array_id: 0,
    data: [Parser.Structs.GlobalData.MemberData]
  ]
end