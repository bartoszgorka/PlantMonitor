defmodule PlantMonitor.Device.AccessToken do
  @moduledoc """
  AccessToken schema required in authorize device request.
  """
  use PlantMonitor.Schema

  schema "access_tokens" do
    field :access_token, :string

    field :device_id, :binary_id

    timestamps()
  end

  @doc """
  `Ecto.Changeset` to create `PlanMonitor.Device.AccessToken` structure.

  ## Parameters
      %{
        access_token :: String.t()
      }
  """
  @changeset_params [:access_token]
  @changeset_req_params [:access_token, :device_id]
  @spec changeset(%PlantMonitor.Device.AccessToken{}, params :: map()) :: %Ecto.Changeset{}
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @changeset_params)
    |> validate_required(@changeset_req_params)
    |> unique_constraint(:access_token, name: :access_token_unique)
  end

end
