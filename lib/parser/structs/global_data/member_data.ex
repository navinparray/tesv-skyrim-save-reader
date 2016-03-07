defmodule Parser.Structs.GlobalData.MemberData do
  @derive [Poison.Encoder]

  defstruct [
    member_name: 0,
    member_type: 0
  ]
end