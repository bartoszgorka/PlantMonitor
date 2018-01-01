defmodule PlantMonitor.Device.AccessTokenTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.Device.AccessToken

  # CHANGESET

  test "[VALID][CHANGESET] New changeset with AccessToken" do
    device_id = Ecto.UUID.generate()
    parameters = %{
      access_token: "Token"
    }

    changeset =
      %AccessToken{device_id: device_id}
      |> AccessToken.changeset(parameters)

    assert changeset.valid?
  end

  test "[INVALID][CHANGESET] Missing parameters" do
    device_id = Ecto.UUID.generate()
    parameters = %{}

    changeset =
      %AccessToken{device_id: device_id}
      |> AccessToken.changeset(parameters)

    refute changeset.valid?
  end

  test "[INVALID][CHANGESET] Duplicated token code" do
    device = insert(:device)
    token = insert(:access_token, %{device_id: device.id})

    parameters = %{
      access_token: token.access_token
    }

    changeset =
      %AccessToken{device_id: device.id}
      |> AccessToken.changeset(parameters)

    result = PlantMonitor.Repo.insert(changeset)
    assert match?({:error, %Ecto.Changeset{}}, result)
  end

end
