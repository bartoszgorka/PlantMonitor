defmodule PlantMonitor.OAuth.AccessToken do
  @moduledoc """
  AccessToken schema required in authorize via OAuth.
  """
  use PlantMonitor.Schema

  schema "access_tokens" do
    field :access_token, :string
    field :permissions, {:array, :string}

    field :user_id, :binary_id

    timestamps()
  end

  @doc """
  `Ecto.Changeset` to create `PlanMonitor.OAuth.AccessToken` structure.

  ## Parameters
      %{
        access_token :: String.t(), code
        permissions :: list(String.t())
      }
  """
  @changeset_params [:access_token, :permissions]
  @changeset_req_params [:access_token, :permissions, :user_id]
  @spec changeset(%PlantMonitor.OAuth.AccessToken{}, params :: map()) :: %Ecto.Changeset{}
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @changeset_params)
    |> validate_required(@changeset_req_params)
    |> unique_constraint(:access_token, name: :access_token_unique)
  end

end
