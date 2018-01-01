defmodule PlantMonitor.Device.AccessTokenServiceTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.Device.AccessTokenService

  # FETCH BY TOKEN

  test "[FETCH_BY_TOKEN] Fetch access token structure" do
    token = insert(:access_token)
    result = AccessTokenService.fetch_by_token(token.access_token)
    assert token == result
  end

  test "[FETCH_BY_TOKEN] No token found" do
    token = "InvalidAccessToken"
    result = AccessTokenService.fetch_by_token(token)
    refute result
  end

  # CREATE TOKEN

  test "[CREATE_TOKEN] Generate access token for our device" do
    device = insert(:device)
    result = AccessTokenService.create_token(device.id)

    assert {:ok, token} = result
    assert String.length(token) == 35
  end

end
