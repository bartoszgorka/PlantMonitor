defmodule PlantMonitorWeb.Helpers.MapHelperTest do
  use PlantMonitorWeb.ConnCase
  alias PlantMonitorWeb.Helpers.MapHelper

  # STRING KEYS TO ATOMS

  test "[STRING_KEYS_TO_ATOMS] Parse keys" do
    input_map = %{
      "first_name" => "John",
      "last_name" => "English"
    }
    expected = %{
      first_name: "John",
      last_name: "English"
    }

    result = MapHelper.string_keys_to_atoms(input_map)
    assert expected == result
  end

end
