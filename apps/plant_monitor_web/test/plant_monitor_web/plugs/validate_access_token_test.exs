defmodule PlantMonitorWeb.Plugs.ValidateAccessTokenTest do
  use PlantMonitorWeb.ConnCase
  alias PlantMonitorWeb.Plugs.ValidateAccessToken

  # VALIDATE ACCESS TOKEN

  test "[PLUGS][VALIDATE_ACCESS_TOKEN] Correct access token" do
    user = insert(:user)
    {:ok, %{access_token: access_token}} = PlantMonitor.OAuth.authorize(user)
    header = "Bearer " <> access_token

    conn =
      build_conn()
      |> Plug.Conn.put_req_header("authorization", header)

    result =
      conn
      |> ValidateAccessToken.call()

    assert Map.has_key?(result.assigns, :claims)
    assert user.id == result.assigns.claims.user_id
  end

  test "[PLUGS][VALIDATE_ACCESS_TOKEN] Check access token" do
    access_token = "MakeSoftwareGreatAgain!"
    header = "Bearer " <> access_token

    conn =
      build_conn()
      |> Plug.Conn.put_req_header("authorization", header)

    result =
      conn
      |> ValidateAccessToken.call()

    assert result.status == 401
  end

end
