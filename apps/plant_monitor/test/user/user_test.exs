defmodule PlantMonitor.UserTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.User
  import PlantMonitor.UserFactory

  # CHANGESET

  test "[VALID][CHANGESET] New changeset with User" do
    parameters = %{
      email: "john@example.com",
      password: "JohnExample"
    }
    changeset =
      %User{}
      |> User.changeset(parameters)

    assert changeset.valid?
  end

  test "[INVALID][CHANGESET] Too short password" do
    parameters = %{
      email: "john@example.com",
      password: "2Sh"
    }
    changeset =
      %User{}
      |> User.changeset(parameters)

    refute changeset.valid?
  end

  test "[INVALID][CHANGESET] Missing password" do
    parameters = %{
      email: "john@example.com"
    }
    changeset =
      %User{}
      |> User.changeset(parameters)

    refute changeset.valid?
  end

  test "[INVALID][CHANGESET] Invalid email format" do
    params = %{
      email: "@",
      password: "LongPassword"
    }

    changeset =
      %User{}
      |> User.changeset(params)

    refute changeset.valid?

    params = %{params | email: "john@"}
    changeset =
      %User{}
      |> User.changeset(params)

    refute changeset.valid?

    params = %{params | email: "john@example"}
    changeset =
      %User{}
      |> User.changeset(params)

    refute changeset.valid?

    params = %{params | email: "@example.com"}
    changeset =
      %User{}
      |> User.changeset(params)

    refute changeset.valid?
  end

  test "[INVALID][CHANGESET] Duplicated email address" do
    user = insert(:user)

    result = PlantMonitor.Repo.insert(%User{} |> User.changeset(%{email: user.email, password: "john_example"}))
    assert match?({:error, %Ecto.Changeset{}}, result)
  end

  # USER FACTORY

  test "[USER FACTORY] Check correct encrypt custom password" do
    password = "example"
    user =
      build(:user, %{password: password})
      |> encrypt_password()
      |> insert()

    assert Comeonin.Bcrypt.checkpw(password, user.encrypted_password)
  end

end
