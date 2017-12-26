defmodule PlantMonitor.UserService do
  @moduledoc """
  `PlantMonitor.User` service.
  """
  alias PlantMonitor.MutationAdapter
  alias PlantMonitor.User
  alias PlantMonitor.Repo
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
  Register new `PlantMonitor.User`.

  ## Parameters
      %{
        email :: String.t()
        password :: String.t()
      }
  ## Returns
      :ok -> register user
      {:error, Ecto.Changeset} -> error in register new User
  """
  @type register_response :: :ok | {:error, %Ecto.Changeset{}}
  @spec register(parameters :: map()) :: register_response
  def register(parameters) do
    %User{}
    |> User.changeset(parameters)
    |> Repo.insert()
    |> MutationAdapter.prevent()
  end

end
