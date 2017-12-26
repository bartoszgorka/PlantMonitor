defmodule PlantMonitor.UserServiceTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.UserService

  # REGISTER

  test "[VALID][REGISTER] Register new user"

  test "[INVALID][REGISTER] Invalid parameters in Register"

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

end
