defmodule PlantMonitorWeb.API.SessionControllerTest do
  use PlantMonitorWeb.ConnCase

  # LOGIN

  test "[SESSION_CONTROLLER][LOGIN] Login to PlantMonitor API" do
    parameters = %{
      email: "john@example.com",
      password: "Password"
    }
    :ok = PlantMonitor.UserService.register(parameters)

    result = post(build_conn(), "/api/login", parameters)
    assert result.status == 201
  end

  test "[SESSION_CONTROLLER][LOGIN] Invalid credentials" do
    user = insert(:user)
    parameters = %{
      email: user.email,
      password: "IdontKnowPassword"
    }

    result = post(build_conn(), "/api/login", parameters)
    assert result.status == 401
  end

  test "[SESSION_CONTROLLER][LOGIN] Invalid parameters" do
    result = post(build_conn(), "/api/login", %{})
    assert result.status == 422
  end

end
