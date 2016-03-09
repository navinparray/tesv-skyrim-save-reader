defmodule Parser.Structs.GlobalData.FunctionLocal do
  @derive [Poison.Encoder]

  defstruct [
    local_name: 0,
    local_type: 0
  ]

end
