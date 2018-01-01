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

end
