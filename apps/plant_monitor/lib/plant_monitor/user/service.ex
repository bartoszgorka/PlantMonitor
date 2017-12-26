defmodule PlantMonitor.UserService do
  @moduledoc """
  `PlantMonitor.User` service.
  """
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

end
