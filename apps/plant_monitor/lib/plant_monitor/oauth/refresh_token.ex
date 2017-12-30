defmodule PlantMonitor.OAuth.RefreshToken do
  @moduledoc """
  RefreshToken schema required in authorize via OAuth.
  """
  use PlantMonitor.Schema

  schema "refresh_tokens" do
    field :refresh_token, :string
    field :secret_code, :string

    field :user_id, :binary_id

    timestamps()
  end

  @doc """
  `Ecto.Changeset` to create `PlanMonitor.OAuth.RefreshToken` structure.

  ## Parameters
      %{
        secret_code :: String.t()
        refresh_token :: String.t()
      }
  """
  @changeset_params [:secret_code, :refresh_token]
  @changeset_req_params [:secret_code, :refresh_token, :user_id]
  @spec changeset(%PlantMonitor.OAuth.RefreshToken{}, params :: map()) :: %Ecto.Changeset{}
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @changeset_params)
    |> validate_required(@changeset_req_params)
    |> unique_constraint(:refresh_token, name: :refresh_token_unique)
  end

end
