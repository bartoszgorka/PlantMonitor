defmodule PlantMonitor.Repo.Migrations.CreateMeasurementDataTable do
  use Ecto.Migration

  def change do
    create table(:measurement_data, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :device_id, references(:devices, type: :uuid, on_delete: :delete_all)

      add :air_temperature, :float
      add :air_humidity, :float

      add :soil_humidity, :float
      add :liquid_level_millimeters, :float

      timestamps()
    end

    create index(:measurement_data, :device_id)
  end

end
