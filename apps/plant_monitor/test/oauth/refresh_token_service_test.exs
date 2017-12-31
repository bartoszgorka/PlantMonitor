defmodule PlantMonitor.OAuth.RefreshTokenServiceTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.OAuth.RefreshToken
  alias PlantMonitor.OAuth.RefreshTokenService

  # GENERATE NEW TOKEN

  test "[GENERATE_NEW_TOKEN] Prepare new refresh token" do
    %{id: user_id} = insert(:user)
    result = RefreshTokenService.generate_new_token(user_id)

    assert {:ok, token} = result
    assert String.length(token.secret_code) == 20
    assert String.length(token.refresh_token) == 20
    assert token.user_id == user_id
  end

  # FETCH TOKEN

  test "[FETCH_TOKEN] No token found" do
    %{id: user_id} = insert(:user)
    token = insert(:refresh_token, %{user_id: user_id})

    params = %{
      secret_code: token.secret_code,
      user_id: Ecto.UUID.generate()
    }

    result = RefreshTokenService.fetch_token(params, token.refresh_token)

    refute result
  end

  test "[FETCH_TOKEN] Refresh token found" do
    %{id: user_id} = insert(:user)
    token = insert(:refresh_token, %{user_id: user_id})

    params = %{
      secret_code: token.secret_code,
      user_id: user_id
    }

    result = RefreshTokenService.fetch_token(params, token.refresh_token)

    assert token == result
  end

  # REFRESH TOKEN

  test "[REFRESH_TOKEN] Receive new token" do
    %{id: user_id} = insert(:user)
    token = insert(:refresh_token, %{user_id: user_id})

    result = RefreshTokenService.refresh_token(token)

    assert {:ok, new_token} = result
    assert token.id != new_token.id
    assert token.user_id == new_token.user_id

    refute Repo.get(RefreshToken, token.id)
  end

end
