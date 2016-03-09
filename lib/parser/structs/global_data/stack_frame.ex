defmodule Parser.Structs.GlobalData.StackFrame do
  @derive [Poison.Encoder]

  defstruct [
    variable_count: 0,
    flag: 0,
    function_type: 0,
    script_name: 0,
    script_base_name: 0,
    event: 0,
    status: 0,
    opcode_version: 0,
    opcode_minor_version: 0,
    return_type: 0,
    function_docstring: 0,
    function_user_flags: 0,
    function_flags: 0,
    function_parameter_Count: 0,
    function_params: [%Parser.Structs.GlobalData.FunctionParam{}],
    function_locals_count: 0,
    function_locals: [%Parser.Structs.GlobalData.FunctionLocal{}],
    opcode_count: 0,
    opcode_data: [%Parser.Structs.GlobalData.OpcodeData{}],
    unkown3: 0,
    unknown4: %Parser.Structs.GlobalData.Variable{},
    unknown5: [%Parser.Structs.GlobalData.Variable{}]
  ]
end
