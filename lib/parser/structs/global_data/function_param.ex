defmodule Parser.Structs.GlobalData.FunctionParam do
  @derive [Poison.Encoder]

  defstruct [
    param_name: 0,
    param_type: 0
  ]

end
