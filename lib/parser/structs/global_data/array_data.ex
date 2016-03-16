defmodule Parser.Structs.GlobalData.ArrayData do
  @derive [Poison.Encoder]

  defstruct [
    array_id: 0,
    member: [Parser.Structs.GlobalData.Variable]
  ]
end
