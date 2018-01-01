defmodule PlantMonitor.DataServiceTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.DataService

  # INSERT DATA

  test "[INSERT_DATA] New measure data" do
    device = insert(:device)
    parameters = %{
      air_temperature: 12,
      air_humidity: 12,
      soil_humidity: 12,
      liquid_level_millimeters: 12,
      device_id: device.id
    }

    result = DataService.insert_data(parameters)
    assert :ok == result
  end

  test "[INSERT_DATA] Missing parameters" do
    device = insert(:device)
    key_to_drop =
      [:air_temperature, :air_humidity, :soil_humidity, :liquid_level_millimeters]
      |> Enum.random()

    parameters = %{
      air_temperature: 12,
      air_humidity: 12,
      soil_humidity: 12,
      liquid_level_millimeters: 12,
      device_id: device.id
    } |> Map.drop([key_to_drop])

    result = DataService.insert_data(parameters)
    assert {:error, %Ecto.Changeset{}} = result
  end

end
