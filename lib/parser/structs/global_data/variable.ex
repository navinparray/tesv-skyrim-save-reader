defmodule Parser.Structs.GlobalData.Variable do
  @derive [Poison.Encoder]

  defstruct [
    type: 0,
    data: 0
  ]
end