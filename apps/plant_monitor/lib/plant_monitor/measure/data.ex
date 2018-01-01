defmodule PlantMonitor.Data do
  @moduledoc """
  Measure data schema.
  """
  use PlantMonitor.Schema

  schema "measurement_data" do
    field :air_temperature, :float
    field :air_humidity, :float

    field :soil_humidity, :float
    field :liquid_level_millimeters, :float

    field :device_id, :binary_id

    timestamps()
  end

  @doc """
  `Ecto.Changeset` to create measure data.

  ## Parameters
      %{
        air_temperature :: float
        air_humidity :: float
        soil_humidity :: float
        liquid_level_millimeters :: float
      }
  """
  @changeset_params [:air_temperature, :air_humidity, :soil_humidity, :liquid_level_millimeters]
  @spec changeset(%PlantMonitor.Data{}, params :: map()) :: %Ecto.Changeset{}
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @changeset_params)
    |> validate_required(@changeset_params)
    |> validate_number(:air_temperature, greater_than_or_equal_to: -100, less_than_or_equal_to: 120)
    |> validate_number(:air_humidity, greater_than_or_equal_to: 0, less_than_or_equal_to: 100)
    |> validate_number(:soil_humidity, greater_than_or_equal_to: 0, less_than_or_equal_to: 100)
    |> validate_number(:liquid_level_millimeters, greater_than_or_equal_to: 0)
  end

end
