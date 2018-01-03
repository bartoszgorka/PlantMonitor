defmodule PlantMonitorWeb.API.DataControllerTest do
  use PlantMonitorWeb.ConnCase

  # CREATE NEW MEASUREMENT DATA

  defp build_authorized_conn(options \\ %{}) do
    access_token =
      case Map.has_key?(options, :access_token) do
        true -> options.access_token
        false ->
          device = insert(:device)
          %{access_token: access_token} = insert(:access_token, %{device_id: device.id})
          access_token
      end

    header = "Basic " <> access_token

    build_conn()
    |> Plug.Conn.put_req_header("authorization", header)
  end

  test "[DATA_CONTROLLER][CREATE] Correct parameters" do
    parameters = %{
      air_temperature: 25.5,
      air_humidity: 35.1,
      soil_humidity: 25.2,
      liquid_level_millimeters: 10
    }
    result =
      build_authorized_conn()
      |> post("/api/measurement_data", parameters)

    assert result.status == 201
  end

  test "[DATA_CONTROLLER][CREATE] Invalid parameters" do
    parameters = %{
      air_temperature: -122225.5,
      air_humidity: 35.1,
      soil_humidity: 25.2,
      liquid_level_millimeters: 10
    }
    result =
      build_authorized_conn()
      |> post("/api/measurement_data", parameters)

    assert result.status == 422
  end

  test "[DATA_CONTROLLER][CREATE] No access token from device" do
    parameters = %{
      air_temperature: 25.5,
      air_humidity: 35.1,
      soil_humidity: 25.2,
      liquid_level_millimeters: 10
    }
    result = post(build_conn(), "/api/measurement_data", parameters)
    assert result.status == 401
  end

  test "[DATA_CONTROLLER][CREATE] Invalid access token from device" do
    parameters = %{
      air_temperature: 25.5,
      air_humidity: 35.1,
      soil_humidity: 25.2,
      liquid_level_millimeters: 10
    }
    options = %{
      access_token: "Invalid access token"
    }

    result =
      options
      |> build_authorized_conn()
      |> post("/api/measurement_data", parameters)
    assert result.status == 401
  end

end
