defmodule PlantMonitor.OAuth do
  @moduledoc """
  OAuth service.
  """
  alias PlantMonitor.OAuth.RefreshToken
  alias PlantMonitor.OAuth.RefreshTokenService

  @doc """
  Authorize user to use PlantMonitor API.

  ## Parameters
      %{
        id :: :uuid,
        permissions :: list(String.t())
      }
  ## Returns
  Check `PlantMonitor.OAuth.generate_token/1` function.
  """
  @spec authorize(%{id: :uuid, permissions: list()}) :: token_response
  def authorize(%{id: user_id, permissions: permissions}) do
    {:ok, token} = RefreshTokenService.generate_new_token(user_id)

    %{
      user_id: user_id,
      permissions: permissions,
      secret_code: token.secret_code,
      refresh_token: token.refresh_token
    } |> generate_token()
  end

  @doc """
  Refresh JWT access token.

  ## Parameters
      access_token :: String.t() - JWT access_token
      refresh_token :: String.t() - Refresh_token received with access access_token

  ## Returns

  Refresh token can be used only once!
  """
  @type refresh_access_token_response :: token_response | {:error, :authorization_fail}
  @spec refresh_access_token(access_token :: String.t(), refresh_token :: String.t()) :: refresh_access_token_response
  def refresh_access_token(access_token, refresh_token) do
    with {:ok, %{user_id: user_id, secret_code: secret_code, permissions: permissions}} <- token_details(access_token),
         %RefreshToken{} = token <- RefreshTokenService.fetch_token(%{user_id: user_id, secret_code: secret_code}, refresh_token),
         {:ok, %{secret_code: secret, refresh_token: refresh}} <- RefreshTokenService.refresh_token(token),
         {:ok, jwt_token_map} <- generate_token(%{user_id: user_id, permissions: permissions, secret_code: secret, refresh_token: refresh})
    do
      {:ok, jwt_token_map}
    else
      nil -> {:error, :authorization_fail}
      :error -> {:error, :authorization_fail}
    end
  end

  @doc """
  Generate access_token valid for an hour from generating.

  ## Parameters
      %{
        user_id :: :uuid
        permissions :: List() with allowed permissions in API,
        secret_code :: String.t(), second validation for token
        refresh_token :: String.t(), refresh_token able for refreshing the access_token
      }

  ## Returns
      {:ok, %{
        access_token :: String.t(),
        expires_in :: integer,
        permissions: list(String.t()),
        refresh_token: String.t()
      }}
  """
  @one_hour 60 * 60
  @type token_response :: {:ok, %{access_token: String.t(), expires_in: integer(), permissions: list(), refresh_token: String.t()}}
  @type generate_token_input :: %{user_id: :uuid, permissions: list(), secret_code: String.t(), refresh_token: String.t()}
  @spec generate_token(map :: generate_token_input) :: token_response
  def generate_token(%{user_id: user_id, permissions: permissions, secret_code: secret_code, refresh_token: refresh_token}) do
    expiration_time = Joken.current_time() + @one_hour

    token_claims = %{
      "alg" => "RS256",
      "exp" => expiration_time,
      "iss" => "plant_monitor",
      "sub" => user_id,
      "cid" => secret_code,
      "aud" => permissions
    }

    private_key =
      Application.get_env(:plant_monitor, :private_key)
      |> Base.decode64!

    token =
      token_claims
      |> Joken.token()
      |> Joken.with_signer(Joken.rs256(JOSE.JWK.from_pem(private_key)))
      |> Joken.sign()
      |> Joken.get_compact()

    {:ok, %{access_token: token, expires_in: @one_hour, permissions: permissions, refresh_token: refresh_token}}
  end

  @doc """
  Validation of the given token, its author and expiration date.

  ## Parameters
      token :: String.t(), JWT token

  ## Returns
      :error -> invalid Token
      {:ok, %{
        user_id: :uuid,
        expire_at_unix: integer(),
        secret_code: String.t(),
        permissions: list(String.t())
      }}
  """
  @type verify_token_response :: {:ok, token_details_map} | :error
  @spec verify_token(token :: String.t()) :: verify_token_response
  def verify_token(token) do
    with {:ok, details} <- token_details(token),
         :ok <- check_expiration_time(details)
    do
      {:ok, details}
    else
      :error -> :error
    end
  end

  @doc """
  Extraction token details from given token.

  ## Parameters
      token :: String.t(), JWT token

  ## Returns
      {:ok, %{
        user_id: :uuid,
        expire_at_unix: integer(),
        secret_code: String.t(),
        permissions: list(String.t())
      }}
  """
  @type token_details_map :: %{user_id: :uuid, expire_at_unix: integer(), secret_code: String.t(), permissions: list()}
  @type token_details_response :: {:ok, token_details_map} | :error
  @spec token_details(token :: String.t()) :: token_details_response
  def token_details(token) do
    with claims = fetch_token_claims(token),
         :ok <- check_claims_size(claims),
         :ok <- check_issuer(claims),
         details = details_as_map(claims)
    do
      {:ok, details}
    else
      :error -> :error
    end
  end

  @spec details_as_map(claims :: map()) :: token_details_map
  defp details_as_map(claims) do
    %{
      user_id: claims["sub"],
      expire_at_unix: claims["exp"],
      secret_code: claims["cid"],
      permissions: claims["aud"]
    }
  end

  @spec fetch_token_claims(token :: String.t()) :: map()
  defp fetch_token_claims(token) do
    public_key =
      Application.get_env(:plant_monitor, :public_key)
      |> Base.decode64!

    token
    |> Joken.token()
    |> Joken.verify(Joken.rs256(JOSE.JWK.from_pem(public_key)))
    |> Map.get(:claims)
  end

  @type check_response :: :ok | :error
  @spec check_claims_size(claims :: map()) :: check_response
  defp check_claims_size(claims) when map_size(claims) == 6, do: :ok
  defp check_claims_size(_claims), do: :error

  @spec check_issuer(claims :: map()) :: check_response
  defp check_issuer(%{"iss" => "plant_monitor"}), do: :ok
  defp check_issuer(_claims), do: :error

  @spec check_expiration_time(token_details_map) :: check_response
  defp check_expiration_time(%{expire_at_unix: expiration_time}) do
    case expiration_time > Joken.current_time() do
      true -> :ok
      false -> :error
    end
  end

end
