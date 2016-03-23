defmodule Parser.Structs.GlobalData.ActiveScriptData do
  @derive [Poison.Encoder]

  defstruct [
    script_id: 0,
    major_version: 0,
    minor_version: 0,
    unknown0: %Parser.Structs.GlobalData.Variable{},
    flag: 0,
    unknown_byte: 0,
    unknown2: 0,
    unknown3: 0,
    unknown4: %{},
    stack_frame_count: 0,
    stack_frame: [%Parser.Structs.GlobalData.StackFrame{}],
    unknown5: 0
  ]
end
