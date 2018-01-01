defmodule PlantMonitor.OAuth.RefreshTokenService do
  @moduledoc """
  Service for `PlantMonitor.OAuth.RefreshToken`
  """
  alias PlantMonitor.OAuth.RefreshToken
  alias PlantMonitor.Repo
  alias Ecto.Multi
  import Ecto.Query

  @doc """
  Insert new `PlantMonitor.OAuth.RefreshToken` structure.

  ## Parameters
      user_id :: :uuid

  ## Returns
      {:ok, PlantMonitor.OAuth.RefreshToken}
  """
  @type generate_new_token_response :: {:ok, %PlantMonitor.OAuth.RefreshToken{}}
  @spec generate_new_token(user_id :: :uuid) :: generate_new_token_response
  def generate_new_token(user_id) do
    parameters = %{
      secret_code: PlantMonitor.Random.random_key(),
      refresh_token: PlantMonitor.Random.random_key()
    }

    %RefreshToken{user_id: user_id}
    |> RefreshToken.changeset(parameters)
    |> Repo.insert()
    |> case do
      {:ok, token} -> {:ok, token}
      {:error, %Ecto.Changeset{}} -> generate_new_token(user_id)
    end
  end

  @doc """
  Fetch `PlantMonitor.OAuth.RefreshToken`.

  ## Parameters
      %{
        user_id :: :uuid,
        secret_code :: String.t()
      },
      refresh_token :: String.t()

  ## Returns
      nil -> No Refresh token!
      PlantMonitor.OAuth.RefreshToken -> in success
  """
  @type fetch_token_response :: %PlantMonitor.OAuth.RefreshToken{} | nil
  @spec fetch_token(%{user_id: :uuid, secret_code: String.t()}, refresh_token :: String.t()) :: fetch_token_response
  def fetch_token(%{user_id: user_id, secret_code: secret}, refresh_token) do
    RefreshToken
    |> where([t], t.user_id == ^user_id)
    |> where([t], t.secret_code == ^secret)
    |> where([t], t.refresh_token == ^refresh_token)
    |> Repo.one()
  end

  @doc """
  Refresh `PlantMonitor.OAuth.RefreshToken`.

  ## Parameters
      token :: PlantMonitor.OAuth.RefreshToken

  ## Returns
      {:ok, PlantMonitor.OAuth.RefreshToken}
  """
  @type refresh_token_response :: {:ok, %PlantMonitor.OAuth.RefreshToken{}}
  @spec refresh_token(token :: %PlantMonitor.OAuth.RefreshToken{}) :: refresh_token_response
  def refresh_token(%{user_id: user_id} = token) do
    Multi.new()
    |> Multi.delete(:old, token)
    |> Multi.run(:token, fn(_) ->
      generate_new_token(user_id)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{token: token}} -> {:ok, token}
    end
  end

end
