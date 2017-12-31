defmodule PlantMonitorWeb.OAuth.AuthorizeController do
  @moduledoc """
  AuthrizeController to refresh access token receive on login.
  """
  use PlantMonitorWeb, :controller
  alias PlantMonitorWeb.ErrorRequest
  alias PlantMonitorWeb.OAuthView

  @doc """
  Refresh access token.

  ## Parameters
      %{
        "grant_type" -> "refresh_token"
        "refresh_token" :: String.t(), code
      }
  """
  @authorization_fail_message "The passed refresh_token is invalid. Check it and try again."
  def refresh_token(%{assigns: %{access_token: access_token}} = conn, %{"grant_type" => "refresh_token", "refresh_token" => refresh_token}) do
    case PlantMonitor.OAuth.refresh_access_token(access_token, refresh_token) do
      {:ok, token_details} ->
        conn
        |> put_status(201)
        |> render(OAuthView, "access_token.json", token_details)
      {:error, :authorization_fail} ->
        conn
        |> ErrorRequest.invalid_request(%{status: 401, message: @authorization_fail_message})
    end
  end
  def refresh_token(conn, _parameters), do: ErrorRequest.invalid_request(conn, %{status: 422})

end
