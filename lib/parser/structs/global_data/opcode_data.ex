defmodule Parser.Structs.GlobalData.OpcodeData do
  @derive [Poison.Encoder]

  defstruct [
    opcode: 0,
    param: [%Parser.Structs.GlobalData.Parameter{}]
  ]

end
