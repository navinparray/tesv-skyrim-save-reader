defmodule Parser.Structs.GlobalData.ArrayInfo do
  @derive [Poison.Encoder]

  defstruct [
    array_id: 0,
    type: 0,
    ref_type: 0,
    length: 0
  ]
end