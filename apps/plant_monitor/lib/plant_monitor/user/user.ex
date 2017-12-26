defmodule PlantMonitor.User do
  @moduledoc """
  User schema - access to Monitor service.
  """
  use PlantMonitor.Schema

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Prepare basic `Ecto.Changeset` to create user.

  ## Parameters
      %{
        email :: String.t(), email format
        password :: String.t(), min. 6 characters
      }
  """
  @changeset_params [:email, :password]
  @duplicated_email_message "This email already used. Try receive password or use new email."
  @spec changeset(%PlantMonitor.User{}, params :: map()) :: %Ecto.Changeset{}
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @changeset_params)
    |> validate_required(@changeset_params)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> unique_constraint(:email, name: :users_email_unique, message: @duplicated_email_message)
    |> encrypt_password()
  end

  @doc """
  Encrypt password from changes in `Ecto.Changeset` and put change to this changeset.

  ## Parameters
      Ecto.Changeset - with password or without

  ## Returns
      Ecto.Changeset
  """
  @spec encrypt_password(map()) :: map()
  def encrypt_password(%{changes: %{password: password}} = changeset), do: changeset |> put_change(:encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
  def encrypt_password(changeset), do: changeset

end
