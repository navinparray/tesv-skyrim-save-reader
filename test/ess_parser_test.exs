defmodule ESSParserTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  doctest ESSParser

  test "parser can open a file for reading" do

    result = ESSParser.parse("docs/file_save_test_One_ingredient.ess")
    assert result == nil
  end

  test "parser returns an error message when a file cannot be read" do

    result = capture_io(fn -> ESSParser.parse("INVALID_FILE_NAME") end)
    assert String.strip(result) == "Could not read the file: INVALID_FILE_NAME"
  end
end
