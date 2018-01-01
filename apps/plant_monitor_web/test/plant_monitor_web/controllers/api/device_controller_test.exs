defmodule PlantMonitorWeb.API.DeviceControllerTest do
  use PlantMonitorWeb.ConnCase

  # CREATE

  defp build_authorized_conn(options) do
    user =
      case Map.has_key?(options, :user) do
        true -> options.user
        false -> insert(:user, %{permissions: options.permissions})
      end
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

    options = %{permissions: ["devices:create"]}
    result =
      options
      |> build_authorized_conn()
      |> post("/api/devices", parameters)

    assert result.status == 201
  end

  test "[DEVICE_CONTROLLER][CREATE] Duplicated device name" do
    permissions = ["devices:create"]
    user = insert(:user, %{permissions: permissions})
    device = insert(:device, %{user_id: user.id})
    parameters = %{
      name: device.name,
      place: "Great Again!"
    }

    options = %{permissions: permissions, user: user}
    result =
      options
      |> build_authorized_conn()
      |> post("/api/devices", parameters)

    assert result.status == 422
  end

  test "[DEVICE_CONTROLLER][CREATE] Missing parameters" do
    parameters = %{
      place: "Great Again!"
    }
    options = %{permissions: ["devices:create"]}

    result =
      options
      |> build_authorized_conn()
      |> post("/api/devices", parameters)

    assert result.status == 422
  end

  test "[DEVICE_CONTROLLER][CREATE] No permissions to create device" do
    parameters = %{
      name: "Make Software",
      place: "Great Again!"
    }
    options = %{permissions: []}
    result =
      options
      |> build_authorized_conn()
      |> post("/api/devices", parameters)

    assert result.status == 403
  end

end
