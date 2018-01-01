defmodule PlantMonitor.DeviceTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.Device

  # CHANGESET

  test "[VALID][CHANGESET] New changeset - measuring device" do
    user_id = Ecto.UUID.generate()
    parameters = %{
      name: "measuring device #1",
      place: "Home"
    }

    changeset =
      %Device{user_id: user_id}
      |> Device.changeset(parameters)

    assert changeset.valid?
  end

  test "[INVALID][CHANGESET] Missing parameters" do
    key_to_drop =
      [:place, :name]
      |> Enum.random()

    user_id = Ecto.UUID.generate()
    parameters = %{
      name: "measuring device #1",
      place: "Home"
    } |> Map.drop([key_to_drop])

    changeset =
      %Device{user_id: user_id}
      |> Device.changeset(parameters)

    refute changeset.valid?
  end

  test "[INVALID][CHANGESET] Duplicated name in device" do
    user = insert(:user)
    token = insert(:refresh_token, %{user_id: user.id})

    parameters = %{
      refresh_token: token.refresh_token,
      secret_code: token.secret_code
    }

    changeset =
      %Device{user_id: user.id}
      |> Device.changeset(parameters)

    result = PlantMonitor.Repo.insert(changeset)
    assert match?({:error, %Ecto.Changeset{}}, result)
  end

end
