defmodule PlantMonitor.ProfileServiceTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.ProfileService

  # PREPARE REGISTER CHANGESET

  test "[PREPARE_REGISTER_CHANGESET] Valid changeset" do
    params = %{
      user_id: Ecto.UUID.generate(),
      first_name: "John",
      last_name: "Coder"
    }

    changeset = ProfileService.prepare_register_changeset(params)
    assert changeset.valid?
  end

  test "[PREPARE_REGISTER_CHANGESET] Invalid changeset" do
    key_to_drop =
      [:first_name, :last_name]
      |> Enum.random()

    parameters = %{
      user_id: Ecto.UUID.generate(),
      first_name: "John",
      last_name: "Coder"
    } |> Map.drop([key_to_drop])

    changeset = ProfileService.prepare_register_changeset(parameters)
    refute changeset.valid?
  end

end
