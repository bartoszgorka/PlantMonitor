defmodule PlantMonitorWeb.API.UserViewTest do
  use PlantMonitorWeb.ConnCase
  alias PlantMonitorWeb.API.UserView

  # RENDER ACCESS TOKEN JSON

  test "[USER VIEW][CORRECT_REGISTER.JSON] Confirm correct register new user" do
    correct = %PlantMonitorWeb.Structs.ConfirmResponse{
      message: "Correct registen in PlantMonitor API. Now you can login and use our API."
    }

    result = Phoenix.View.render(UserView,  "correct_register.json", %{})
    assert correct == result
  end

end
