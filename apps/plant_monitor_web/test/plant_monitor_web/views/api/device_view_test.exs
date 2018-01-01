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

  # RENDER DEVICES LIST JSON

  test "[DEVICE VIEW][DEVICES_LIST.JSON] Device lists" do
    correct = %PlantMonitorWeb.Structs.Device.DevicesListResponse{
      pagination: %PlantMonitorWeb.Structs.Repo.Pagination{
        limit: 10,
        page: 1
      },
      devices: [
        %PlantMonitorWeb.Structs.Device.Device{
          id: "123",
          name: "Make",
          place: "Software"
        },
        %PlantMonitorWeb.Structs.Device.Device{
          id: "321",
          name: "Great",
          place: "Again"
        }
      ]
    }

    parameters = %{
      pagination: %{
        limit: 10,
        page: 1
      },
      results: [
        %PlantMonitor.Device{
          id: "123",
          name: "Make",
          place: "Software"
        },
        %PlantMonitor.Device{
          id: "321",
          name: "Great",
          place: "Again"
        }
      ]
    }

    result = Phoenix.View.render(DeviceView,  "devices_list.json", parameters)
    assert correct == result
  end

end
