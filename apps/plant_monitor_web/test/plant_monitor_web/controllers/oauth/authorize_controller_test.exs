defmodule PlantMonitorWeb.OAuth.AuthorizeControllerTest do
  use PlantMonitorWeb.ConnCase

  # REFRESH TOKEN

  test "[AUTHORIZE_CONTROLLER][REFRESH_TOKEN] Refresh access token" do
    user = insert(:user)
    {:ok, details} = PlantMonitor.OAuth.authorize(user)
    body = %{
      grant_type: "refresh_token",
      refresh_token: details.refresh_token
    }

    header = "Bearer " <> details.access_token
    authorized =
      build_conn()
      |> Plug.Conn.put_req_header("authorization", header)

    result = post(authorized, "/oauth/token", body)
    assert result.status == 201
  end

  test "[AUTHORIZE_CONTROLLER][REFRESH_TOKEN] Invalid refresh token" do
    user = insert(:user)
    {:ok, details} = PlantMonitor.OAuth.authorize(user)
    body = %{
      grant_type: "refresh_token",
      refresh_token: "Invalid refresh token"
    }

    header = "Bearer " <> details.access_token
    authorized =
      build_conn()
      |> Plug.Conn.put_req_header("authorization", header)

    result = post(authorized, "/oauth/token", body)
    assert result.status == 401
  end

  test "[AUTHORIZE_CONTROLLER][REFRESH_TOKEN] Unknown grant type method" do
    user = insert(:user)
    {:ok, details} = PlantMonitor.OAuth.authorize(user)
    body = %{
      grant_type: "authorize",
      refresh_token: details.refresh_token
    }

    header = "Bearer " <> details.access_token
    authorized =
      build_conn()
      |> Plug.Conn.put_req_header("authorization", header)

    result = post(authorized, "/oauth/token", body)
    assert result.status == 422
  end

end
