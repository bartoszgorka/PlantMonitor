defmodule PlantMonitorWeb.Plugs.ValidateSensorRequestTest do
  use PlantMonitorWeb.ConnCase
  alias PlantMonitorWeb.Plugs.ValidateSensorRequest

  # VALIDATE SENSOR REQUEST

  test "[PLUGS][VALIDATE_SENSOR_REQUEST] Correct access token" do
    user = insert(:user)
    device = insert(:device, %{user_id: user.id})
    %{access_token: access_token} = insert(:access_token, %{device_id: device.id})

    header = "Basic " <> access_token

    conn =
      build_conn()
      |> Plug.Conn.put_req_header("authorization", header)

    result =
      conn
      |> ValidateSensorRequest.call()

    assert Map.has_key?(result.assigns, :device_id)
    assert device.id == result.assigns.device_id
  end

  test "[PLUGS][VALIDATE_SENSOR_REQUEST] Check access token" do
    access_token = "MakeSoftwareGreatAgain!"
    header = "Basic " <> access_token

    conn =
      build_conn()
      |> Plug.Conn.put_req_header("authorization", header)

    result =
      conn
      |> ValidateSensorRequest.call()

    assert result.status == 401
  end

end
