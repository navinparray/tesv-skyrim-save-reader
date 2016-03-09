defmodule Parser.Structs.GlobalData.Parameter do
  @derive [Poison.Encoder]

  defstruct [
    param_type: 0,
    param_data: 0
  ]

end
