defmodule PlantMonitorWeb.API.DeviceView do
  @moduledoc """
  Device view render.
  """
  use PlantMonitorWeb, :view
  alias PlantMonitorWeb.Structs.ConfirmResponse
  alias PlantMonitorWeb.API.RepoView
  alias PlantMonitorWeb.Structs.Device.Device
  alias PlantMonitorWeb.Structs.Device.DevicesListResponse

  def render("correct_register.json", _assigns) do
    %ConfirmResponse{
      message: "We prepare your device correctly."
    }
  end

  def render("devices_list.json", result) do
    %DevicesListResponse{
      pagination: RepoView.render_pagination(result),
      devices: devices_details(result)
    }
  end

  defp devices_details(%{results: results}) do
    results
    |> Enum.map(fn device ->
      device_details(device)
    end)
  end

  defp device_details(device) do
    %Device{
      id: device.id,
      name: device.name,
      place: device.place
    }
  end

end
