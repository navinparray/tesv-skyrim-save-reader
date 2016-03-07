defmodule Parser.Structs.GLobalData.References do
  @derive [Poison.Encoder]

  defstruct [
    reference_id: 0,
    type: 0
  ]
end