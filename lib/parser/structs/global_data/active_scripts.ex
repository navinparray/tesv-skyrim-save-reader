defmodule Parser.Structs.GlobalData.ActiveScripts do
  @derive [Poison.Encoder]

  defstruct [
    script_id: 0,
    script_type: 0
  ]
end