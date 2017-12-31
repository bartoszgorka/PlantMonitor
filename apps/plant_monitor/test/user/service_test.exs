defmodule PlantMonitor.UserServiceTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.UserService
  import PlantMonitor.UserFactory

  # REGISTER

  test "[VALID][REGISTER] Register new user" do
    parameters = %{
      email: "john@example.com",
      password: "Password"
    }

    result = UserService.register(parameters)

    assert :ok == result
  end

  test "[INVALID][REGISTER] Duplicated email" do
    user = insert(:user)
    parameters = %{
      email: user.email,
      password: "Password"
    }

    result = UserService.register(parameters)

    assert {:error, %Ecto.Changeset{}} = result
  end

  test "[INVALID][REGISTER] Invalid password" do
    parameters = %{
      email: "john@example.com",
      password: "2SH"
    }

    result = UserService.register(parameters)

    assert {:error, %Ecto.Changeset{}} = result
  end

  # FETCH USER BY EMAIL

  test "[VALID][FETCH_USER_BY_EMAIL] Find user" do
    user = insert(:user)
    result = UserService.fetch_user_by_email(user.email)

    assert user.id == result.id
  end

  test "[INVALID][FETCH_USER_BY_EMAIL] No user found" do
    result = UserService.fetch_user_by_email("NOT EXISTS")

    refute result
  end

  # LOGIN

  test "[LOGIN] Correct credentials" do
    password = "Password"
    user =
      build(:user, %{password: password})
      |> encrypt_password()
      |> insert()

    parameters = %{
      email: user.email,
      password: password
    }

    result = UserService.login(parameters)
    assert {:ok, _token} = result
  end

  test "[LOGIN] No found email (user)" do
    parameters = %{
      email: "john@example.com",
      password: "Password"
    }

    result = UserService.login(parameters)
    assert {:error, :invalid_credentials} == result
  end

  test "[LOGIN] Invalid credentials" do
    user = insert(:user)
    parameters = %{
      email: user.email,
      password: "IdontKnowPassword"
    }

    result = UserService.login(parameters)
    assert {:error, :invalid_credentials} == result
  end

end
