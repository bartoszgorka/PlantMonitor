defmodule PlantMonitorWeb.API.DataViewTest do
  use PlantMonitorWeb.ConnCase
  alias PlantMonitorWeb.API.DataView

  # CONFIRM INSERT JSON

  test "[DATA VIEW][CONFIRM_INSERT.JSON] Confirm insert new measurement data" do
    correct = %PlantMonitorWeb.Structs.ConfirmResponse{
      message: "We inserted your measurement data."
    }

    result = Phoenix.View.render(DataView,  "confirm_insert.json", %{})
    assert correct == result
  end

end
