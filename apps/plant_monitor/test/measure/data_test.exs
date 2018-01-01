defmodule PlantMonitor.DataTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.Data

  # CHANGESET

  test "[VALID][CHANGESET] New changeset - measure data" do
    device_id = Ecto.UUID.generate()
    parameters = %{
      air_temperature: 12,
      air_humidity: 12,
      soil_humidity: 12,
      liquid_level_millimeters: 12
    }

    changeset =
      %Data{device_id: device_id}
      |> Data.changeset(parameters)

    assert changeset.valid?
  end

  test "[INVALID][CHANGESET] Missing parameters" do
    key_to_drop =
      [:air_temperature, :air_humidity, :soil_humidity, :liquid_level_millimeters]
      |> Enum.random()

    device_id = Ecto.UUID.generate()
    parameters = %{
      air_temperature: 12,
      air_humidity: 12,
      soil_humidity: 12,
      liquid_level_millimeters: 12
    } |> Map.drop([key_to_drop])

    changeset =
      %Data{device_id: device_id}
      |> Data.changeset(parameters)

    refute changeset.valid?
  end

end
