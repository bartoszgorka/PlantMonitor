defmodule PlantMonitorWeb.API.UserController do
  @moduledoc """
  User Controller - Register new user to PlantMonitor API.
  """
  use PlantMonitorWeb, :controller
  alias PlantMonitorWeb.API.UserView
  alias PlantMonitorWeb.ErrorRequest

  @doc """
  Register new user.

  ## Parameters
      %{
        "email" :: String.t()
        "password" :: String.t()
        "first_name" :: String.t()
        "last_name" :: String.t()
      }
  """
  def register(conn, %{"email" => email, "password" => password, "first_name" => name, "last_name" => surname}) do
    personal_data = %{
      email: email,
      password: password,
      profile: %{
        first_name: name,
        last_name: surname
      }
    }

    case PlantMonitor.UserService.register(personal_data) do
      :ok ->
        conn
        |> put_status(201)
        |> render(UserView, "correct_register.json", %{})
      {:error, changeset} ->
        conn
        |> ErrorRequest.invalid_request(changeset)
    end
  end
  def register(conn, _parameters), do: ErrorRequest.invalid_request(conn, %{status: 422})

end
