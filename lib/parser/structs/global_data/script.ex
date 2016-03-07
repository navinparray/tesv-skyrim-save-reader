defmodule Parser.Structs.GlobalData.Script do
  @derive [Poison.Encoder]

  defstruct [
    script_name: 0,
    script_type: 0,
    member_count: 0,
    member_data: [Parser.Structs.GlobalData.MemberData]
  ]  
end