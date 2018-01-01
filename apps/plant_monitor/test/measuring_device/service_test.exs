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

  # FETCH DEVICE

  test "[FETCH_DEVICE] Device found" do
    device = insert(:device)
    result = DeviceService.fetch_device(device.id)
    assert device == result
  end

  test "[FETCH_DEVICE] No device found" do
    device_id = Ecto.UUID.generate()
    result = DeviceService.fetch_device(device_id)
    refute result
  end

  # GET DEVICES

  test "[GET_DEVICES] List of devices" do
    %{id: user_id} = insert(:user)
    _devices = insert_list(3, :device, %{user_id: user_id})

    result = DeviceService.get_devices(user_id)
    assert %{results: devices_list} = result
    assert length(devices_list) == 3
  end

  test "[GET_DEVICES] Custom limit" do
    %{id: user_id} = insert(:user)
    _devices = insert_list(2, :device, %{user_id: user_id})

    result = DeviceService.get_devices(user_id, %{"limit" => "1"})
    assert %{results: devices_list} = result
    assert length(devices_list) == 1
  end

  test "[GET_DEVICES] Empty results" do
    %{id: first_id} = insert(:user)
    %{id: user_id} = insert(:user)
    _devices = insert_list(2, :device, %{user_id: user_id})

    result = DeviceService.get_devices(first_id)
    assert %{results: devices_list} = result
    assert Enum.empty?(devices_list)
  end

  # DELETE DEVICE

  test "[DELETE_DEVICE] Correct delete device" do
    %{id: user_id} = insert(:user)
    device = insert(:device, %{user_id: user_id})

    result = DeviceService.delete_device(%{user_id: user_id, device_id: device.id})
    assert :ok == result
  end

  test "[DELETE_DEVICE] Try delete device prepared by another user" do
    %{id: user_id} = insert(:user)
    %{id: first_id} = insert(:user)
    device = insert(:device, %{user_id: first_id})

    result = DeviceService.delete_device(%{user_id: user_id, device_id: device.id})
    assert :error == result
  end

  test "[DELETE_DEVICE] Invalid Device ID - not UUID" do
    %{id: user_id} = insert(:user)
    device_id = "Not UUID ID"

    result = DeviceService.delete_device(%{user_id: user_id, device_id: device_id})
    assert :error == result
  end

end
