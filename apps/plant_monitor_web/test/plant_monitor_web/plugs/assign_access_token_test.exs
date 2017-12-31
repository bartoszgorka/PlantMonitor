defmodule PlantMonitorWeb.Plugs.AssignAccessTokenTest do
  use PlantMonitorWeb.ConnCase
  alias PlantMonitorWeb.Plugs.AssignAccessToken

  # ASSIGN ACCESS TOKEN

  test "[PLUGS][ASSIGN_ACCESS_TOKEN] Fetch access token from conn" do
    access_token = "MakeSoftwareGreatAgain!"
    header = "Bearer " <> access_token

    conn =
      build_conn()
      |> Plug.Conn.put_req_header("authorization", header)

    result =
      conn
      |> AssignAccessToken.call()

    assert access_token == result.assigns[:access_token]
  end

  test "[PLUGS][ASSIGN_ACCESS_TOKEN] No access token found" do
    access_token = "MakeSoftwareGreatAgain!"
    header = "NotBearer " <> access_token

    conn =
      build_conn()
      |> Plug.Conn.put_req_header("authorization", header)

    result =
      conn
      |> AssignAccessToken.call()

    refute result.assigns[:access_token]
    # We also should check not exists key. No assign nil as access token!
    refute Map.has_key?(result.assigns, :access_token)
  end

end
