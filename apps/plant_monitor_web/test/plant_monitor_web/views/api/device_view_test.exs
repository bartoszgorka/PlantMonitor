defmodule PlantMonitorWeb.API.DeviceViewTest do
  use PlantMonitorWeb.ConnCase
  alias PlantMonitorWeb.API.DeviceView

  # CORRECT REGISTER JSON

  test "[DEVICE VIEW][CORRECT_REGISTER.JSON] Confirm correct register new device" do
    correct = %PlantMonitorWeb.Structs.ConfirmResponse{
      message: "We prepare your device correctly."
    }

    result = Phoenix.View.render(DeviceView,  "correct_register.json", %{})
    assert correct == result
  end

end
