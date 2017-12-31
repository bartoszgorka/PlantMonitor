defmodule PlantMonitorWeb.API.UserControllerTest do
  use PlantMonitorWeb.ConnCase

  # REGISTER

  test "[USER_CONTROLLER][REGISTER] Register in PlantMonitor API" do
    parameters = %{
      email: "Make@example.com",
      password: "Software",
      first_name: "Great",
      last_name: "Again!"
    }

    result = post(build_conn(), "/api/users", parameters)
    assert result.status == 201
  end

  test "[USER_CONTROLLER][REGISTER] Duplicated email" do
    user = insert(:user)
    parameters = %{
      email: user.email,
      password: "Make_Software",
      first_name: "Great",
      last_name: "Again!"
    }

    result = post(build_conn(), "/api/users", parameters)
    assert result.status == 422
  end

  test "[USER_CONTROLLER][REGISTER] Invalid parameters" do
    parameters = %{
      email: "Make",
      password: "Software",
      first_name: "Great",
      last_name: "Again!"
    }

    result = post(build_conn(), "/api/users", parameters)
    assert result.status == 422
  end

  test "[USER_CONTROLLER][REGISTER] Missing parameters" do
    result = post(build_conn(), "/api/users", %{})
    assert result.status == 422
  end

end
