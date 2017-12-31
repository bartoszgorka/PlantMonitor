defmodule PlantMonitor.UserService do
  @moduledoc """
  `PlantMonitor.User` service.
  """
  alias PlantMonitor.MutationAdapter
  alias PlantMonitor.User
  alias PlantMonitor.Repo
  alias Ecto.Multi
  import Ecto.Query

  @doc """
  Fetch user by email

  ## Parameters
      email :: String.t()

  ## Returns
      PlantMonitor.User -> user found
      nil -> no user found
  """
  @type fetch_response :: %PlantMonitor.User{} | nil
  @spec fetch_user_by_email(email :: String.t()) :: fetch_response
  def fetch_user_by_email(email) do
    User
    |> where([u], u.email == ^email)
    |> Repo.one()
  end

  @doc """
  Register new `PlantMonitor.User` (with required profile)

  ## Parameters
      %{
        email :: String.t()
        password :: String.t()
        profile: %{
          first_name :: String.t(),
          last_name :: String.t()
        }
      }
  ## Returns
      :ok -> register user with profile
      {:error, Ecto.Changeset} -> error in register new User
  """
  @type register_response :: :ok | {:error, %Ecto.Changeset{}}
  @spec register(params :: map()) :: register_response
  def register(%{profile: profile} = params) do
    Multi.new()
    |> Multi.insert(:user, User.changeset(%User{}, params))
    |> Multi.run(:profile, fn %{user: user} ->
      profile
      |> Map.merge(%{user_id: user.id})
      |> PlantMonitor.ProfileService.prepare_register_changeset()
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> MutationAdapter.prevent()
  end

  @doc """
  Login user to PlantMonitor API.

  ## Parameters
      %{
        email :: String.t(),
        password :: String.t()
      }

  ## Returns
      {:error, :invalid_credentials} -> when invalid user's credentials
      {:ok, %{access_token: String.t(), expires_in: integer(), permissions: list(), refresh_token: String.t()}} -> correct login
  """
  @type login_response :: {:ok, %{access_token: String.t(), expires_in: integer(), permissions: list(), refresh_token: String.t()}} | {:error, :invalid_credentials}
  @spec login(%{email: String.t(), password: String.t()}) :: login_response
  def login(%{email: email, password: password}) do
    with %User{id: user_id, permissions: permissions} = user <- fetch_user_by_email(email),
         true <- validate_password(user, password),
         {:ok, token} <- PlantMonitor.OAuth.authorize(%{id: user_id, permissions: permissions})
    do
      {:ok, token}
    else
      nil -> {:error, :invalid_credentials}
      false -> {:error, :invalid_credentials}
    end
  end

  defp validate_password(%{encrypted_password: encrypted}, password) when is_binary(password) do
    password
    |> Comeonin.Bcrypt.checkpw(encrypted)
  end
  defp validate_password(_user, _password), do: false

end
