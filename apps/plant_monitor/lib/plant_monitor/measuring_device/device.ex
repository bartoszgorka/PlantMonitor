defmodule PlantMonitor.Device do
  @moduledoc """
  Measuring device schema.
  """
  use PlantMonitor.Schema

  schema "devices" do
    field :name, :string
    field :place, :string

    field :user_id, :binary_id

    timestamps()
  end

  @doc """
  `Ecto.Changeset` to create measuring device.

  ## Parameters
      %{
        name :: String.t()
        place :: String.t()
      }
  """
  @changeset_params [:name, :place]
  @duplicated_name_message "You already registered device with this name. Select another name."
  @spec changeset(%PlantMonitor.Device{}, params :: map()) :: %Ecto.Changeset{}
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @changeset_params)
    |> validate_required(@changeset_params)
    |> validate_length(:name, max: 255)
    |> validate_length(:place, max: 255)
    |> unique_constraint(:name, name: :devices_name_unique, message: @duplicated_name_message)
  end

end
