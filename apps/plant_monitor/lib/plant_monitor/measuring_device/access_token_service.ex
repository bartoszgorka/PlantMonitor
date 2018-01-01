defmodule PlantMonitor.Device.AccessTokenService do
  @moduledoc """
  Service - `PlantMonitor.Device.AccessToken` schema.
  """
  alias PlantMonitor.Device.AccessToken
  alias PlantMonitor.Random
  alias PlantMonitor.Repo
  import Ecto.Query

  @doc """
  Fetch `PlantMonitor.Device.AccessToken` by access token.

  ## Parameters
      token :: String.t()

  ## Returns
      PlantMonitor.Device.AccessToken -> success
      nil -> no token found
  """
  @type fetch_response :: %PlantMonitor.Device.AccessToken{} | nil
  @spec fetch_by_token(token :: String.t()) :: fetch_response
  def fetch_by_token(token) do
    AccessToken
    |> where([t], t.access_token == ^token)
    |> Repo.one()
  end

  @doc """
  Create AccessToken to authorize device request.

  ## Parameters
      device_id :: :uuid

  ## Returns
      {:ok, token :: String.t()}
  """
  @type create_token_response :: {:ok, token :: String.t()}
  @spec create_token(device_id :: :uuid) :: create_token_response
  def create_token(device_id) do
    params = %{
      access_token: Random.random_key(35)
    }

    %AccessToken{device_id: device_id}
    |> AccessToken.changeset(params)
    |> Repo.insert()
    |> case do
      {:ok, %{access_token: token}} -> {:ok, token}
      {:error, %Ecto.Changeset{}} -> create_token(device_id)
    end
  end

end
