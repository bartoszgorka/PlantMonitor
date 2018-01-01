defmodule PlantMonitorWeb.Plugs.SplitTokenClaimsTest do
  use PlantMonitorWeb.ConnCase
  alias PlantMonitorWeb.Plugs.SplitTokenClaims

  # SPLIT TOKEN CLAIMS

  test "[PLUGS][SPLIT_TOKEN_CLAIMS] Check assigns" do
    params = %{
      user_id: Ecto.UUID.generate(),
      permissions: ["make", "software", "great", "again"]
    }

    conn =
      build_conn()
      |> Plug.Conn.assign(:claims, params)

    result =
      conn
      |> SplitTokenClaims.call()

    assert params.permissions == result.assigns[:permissions]
    assert params.user_id == result.assigns[:user_id]
  end

end
