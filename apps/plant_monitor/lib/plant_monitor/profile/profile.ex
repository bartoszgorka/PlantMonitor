defmodule PlantMonitor.Profile do
  @moduledoc """
  Profile schema. Belongs to `PlantMonitor.User`.
  """
  use PlantMonitor.Schema

  schema "profiles" do
    field :first_name, :string
    field :last_name, :string

    field :user_id, :binary_id

    timestamps()
  end

  @doc """
  `Ecto.Changeset` to create user's profile.

  ## Parameters
      %{
        first_name :: String.t()
        last_name :: String.t()
      }
  """
  @changeset_params [:first_name, :last_name]
  @duplicated_user_message "This user already has profile. Can not prepare second."
  @spec changeset(%PlantMonitor.Profile{}, params :: map()) :: %Ecto.Changeset{}
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @changeset_params)
    |> validate_required(@changeset_params)
    |> validate_length(:first_name, max: 255)
    |> validate_length(:last_name, max: 255)
    |> unique_constraint(:user_id, name: :profile_user_id_unique, message: @duplicated_user_message)
  end

end
