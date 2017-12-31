defmodule PlantMonitor.OAuthTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.OAuth

  # GENERATE TOKEN

  test "[GENERATE_TOKEN] Correct generate token" do
    token_params = %{
      user_id: Ecto.UUID.generate(),
      permissions: ["plants", "history"],
      refresh_token: "my_refresh_token",
      secret_code: "Make Software Great Again!"
    }

    result = OAuth.generate_token(token_params)
    assert {:ok, %{access_token: token, permissions: permissions, expires_in: time, refresh_token: refresh_token}} = result
    assert refresh_token == token_params.refresh_token
    assert permissions == token_params.permissions
    assert time == 3600
    assert String.length(token) > 0
  end

  # VERIFY TOKEN

  test "[VERIFY_TOKEN] Verify valid token" do
    token_params = %{
      user_id: Ecto.UUID.generate(),
      permissions: ["plants", "history"],
      refresh_token: "my_refresh_token",
      secret_code: "Make Software Great Again!"
    }

    {:ok, %{access_token: token}} = OAuth.generate_token(token_params)
    result = OAuth.verify_token(token)

    assert {:ok, claims} = result
    assert claims.user_id == token_params.user_id
    assert claims.expire_at_unix > 0
    assert claims.secret_code == token_params.secret_code
    assert claims.permissions == token_params.permissions
  end

  defp gen_token(token_params) do
    private_key =
      Application.get_env(:plant_monitor, :private_key)
      |> Base.decode64!

    token_params
      |> Joken.token()
      |> Joken.with_signer(Joken.rs256(JOSE.JWK.from_pem(private_key)))
      |> Joken.sign()
      |> Joken.get_compact()
  end

  test "[VERIFY_TOKEN] Invalid token send as access_token" do
    example_token = gen_token(%{})

    result = OAuth.verify_token(example_token)
    assert :error == result
  end

  test "[VERIFY_TOKEN] Expired token" do
    expiration_time = Joken.current_time() - 10_000
    token_claims = %{
      "alg" => "RS256",
      "exp" => expiration_time,
      "iss" => "plant_monitor",
      "sub" => "user_id",
      "cid" => "secret",
      "aud" => "permissions"
    }

    example_token = gen_token(token_claims)
    result = OAuth.verify_token(example_token)
    assert :error == result
  end

  test "[VERIFY_TOKEN] Invalid signed token" do
    expiration_time = Joken.current_time() + 1000
    token_claims = %{
      "alg" => "RS256",
      "exp" => expiration_time,
      "iss" => "NOT A plant_monitor",
      "sub" => "user_id",
      "cid" => "secret",
      "aud" => "permissions"
    }

    example_token = gen_token(token_claims)
    result = OAuth.verify_token(example_token)
    assert :error == result
  end

  test "[VERIFY_TOKEN] Invalid claims size in token" do
    expiration_time = Joken.current_time() + 1000
    token_claims = %{
      "alg" => "RS256",
      "exp" => expiration_time,
      "iss" => "plant_monitor",
      "sub" => "user_id",
      "aud" => "permissions"
    }

    example_token = gen_token(token_claims)
    result = OAuth.verify_token(example_token)
    assert :error == result
  end

  # TOKEN DETAILS

  test "[TOKEN_DETAILS] Fetch claims from token" do
    expiration_time = Joken.current_time() + 1000
    token_claims = %{
      "alg" => "RS256",
      "exp" => expiration_time,
      "iss" => "plant_monitor",
      "sub" => "user_id",
      "cid" => "secret",
      "aud" => "permissions"
    }

    expected = %{
      user_id: "user_id",
      expire_at_unix: expiration_time,
      secret_code: "secret",
      permissions: "permissions"
    }

    access_token = gen_token(token_claims)
    result = OAuth.token_details(access_token)

    assert {:ok, claims} = result
    assert expected == claims
  end

  # AUTHORIZE

  test "[AUTHORIZE] Authorize access to PlantMonitor API" do
    user = insert(:user, %{permissions: ["plants", "history"]})

    result = OAuth.authorize(user)
    assert {:ok, %{access_token: token, permissions: permissions, expires_in: time}} = result
    assert permissions == user.permissions
    assert time == 3600
    assert String.length(token) > 0
  end

  # REFRESH TOKEN

  test "[REFRESH_TOKEN] Correct refresh access_token" do
    user = insert(:user, %{permissions: ["plants", "history"]})
    {:ok, token} = OAuth.authorize(user)

    result = OAuth.refresh_access_token(token.access_token, token.refresh_token)
    assert {:ok, details} = result
    assert details.permissions == token.permissions
    assert details.expires_in == 3600
    assert String.length(details.access_token) > 0
    assert String.length(details.refresh_token) > 0
  end

  test "[REFRESH_TOKEN] Invalid refresh_token" do
    user = insert(:user, %{permissions: ["plants", "history"]})
    {:ok, token} = OAuth.authorize(user)

    result = OAuth.refresh_access_token(token.access_token, "Invalid Token")
    assert {:error, :authorization_fail} == result
  end

  test "[REFRESH_TOKEN] Invalid user_id with refresh_token" do
    user = insert(:user, %{permissions: ["plants", "history"]})
    second_user = insert(:user)
    code = insert(:refresh_token, %{user_id: second_user.id})

    expiration_time = Joken.current_time() + 10_000
    token_claims = %{
      "alg" => "RS256",
      "exp" => expiration_time,
      "iss" => "plant_monitor",
      "sub" => user.id,
      "cid" => code.secret_code,
      "aud" => user.permissions
    }

    token = gen_token(token_claims)

    result = OAuth.refresh_access_token(token, code.refresh_token)
    assert {:error, :authorization_fail} == result
  end

end
