defmodule PlantMonitorWeb.API.SessionController do
  @moduledoc """
  SessionController allowed login to PlantMonitor API.
  """
  use PlantMonitorWeb, :controller
  alias PlantMonitorWeb.ErrorRequest
  alias PlantMonitorWeb.OAuthView

  @doc """
  Login as User to API.

  ## Parameters
      %{
        "email" :: String.t(),
        "password" :: String.t()
      }
  """
  @invalid_credentials_message "Invalid credentials. You can not login!"
  def login(conn, %{"email" => email, "password" => password}) do
    credentials = %{
      email: email,
      password: password
    }

    case PlantMonitor.UserService.login(credentials) do
      {:ok, token_details} ->
        conn
        |> put_status(201)
        |> render(OAuthView, "access_token.json", token_details)
      {:error, :invalid_credentials} ->
        conn
        |> ErrorRequest.invalid_request(%{status: 401, message: @invalid_credentials_message})
    end
  end
  def login(conn, _parameters), do: ErrorRequest.invalid_request(conn, %{status: 422})

end
