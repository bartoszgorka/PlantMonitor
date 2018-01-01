defmodule PlantMonitor.Device.AccessTokenService do
  @moduledoc """
  Service - `PlantMonitor.Device.AccessToken` schema.
  """
  alias PlantMonitor.Device.AccessToken
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

end
