defmodule PlantMonitorWeb.API.DeviceControllerTest do
  use PlantMonitorWeb.ConnCase

  # CREATE

  defp build_authorized_conn(permissions) do
    user = insert(:user, %{permissions: permissions})
    {:ok, %{access_token: access_token}} = PlantMonitor.OAuth.authorize(user)

    header = "Bearer " <> access_token

    build_conn()
    |> Plug.Conn.put_req_header("authorization", header)
  end

  test "[DEVICE_CONTROLLER][CREATE] Register new measuring device" do
    parameters = %{
      name: "Make Software",
      place: "Great Again!"
    }
    permissions = ["devices:create"]

    result =
      permissions
      |> build_authorized_conn()
      |> post("/api/devices", parameters)

    assert result.status == 201
  end

  test "[DEVICE_CONTROLLER][CREATE] Duplicated device name" do
    device = insert(:device)
    parameters = %{
      name: device.name,
      place: "Great Again!"
    }

    permissions = ["devices:create"]

    result =
      permissions
      |> build_authorized_conn()
      |> post("/api/devices", parameters)

    assert result.status == 422
  end

  test "[DEVICE_CONTROLLER][CREATE] Missing parameters" do
    parameters = %{
      place: "Great Again!"
    }
    permissions = ["devices:create"]

    result =
      permissions
      |> build_authorized_conn()
      |> post("/api/devices", parameters)

    assert result.status == 422
  end

  test "[DEVICE_CONTROLLER][CREATE] No permissions to create device" do
    parameters = %{
      name: "Make Software",
      place: "Great Again!"
    }
    permissions = []

    result =
      permissions
      |> build_authorized_conn()
      |> post("/api/devices", parameters)

    assert result.status == 403
  end

end
