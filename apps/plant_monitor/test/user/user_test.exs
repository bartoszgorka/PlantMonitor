defmodule PlantMonitor.UserTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.User

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
    email = "john@example.com"
    _user = PlantMonitor.Repo.insert!(%User{email: email})

    result = PlantMonitor.Repo.insert(%User{} |> User.changeset(%{email: email, password: "john_example"}))
    assert match?({:error, %Ecto.Changeset{}}, result)
  end

end
