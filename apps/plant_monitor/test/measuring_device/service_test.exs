defmodule PlantMonitor.DeviceServiceTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.DeviceService

  # REGISTER

  test "[REGISTER] Correct register new measuring device" do
    user = insert(:user)
    parameters = %{
      user_id: user.id,
      name: "Measuring device",
      place: "My home"
    }

    result = DeviceService.register(parameters)
    assert :ok == result
  end

  test "[REGISTER] Invalid parameters" do
    user = insert(:user)
    parameters = %{
      user_id: user.id,
      name: "",
      place: "My home"
    }

    result = DeviceService.register(parameters)
    assert {:error, %Ecto.Changeset{}} = result
  end

  test "[REGISTER] Duplicated name" do
    user = insert(:user)
    device = insert(:device, %{user_id: user.id})

    parameters = %{
      user_id: user.id,
      name: device.name,
      place: "My home"
    }

    result = DeviceService.register(parameters)
    assert {:error, %Ecto.Changeset{}} = result
  end

end
