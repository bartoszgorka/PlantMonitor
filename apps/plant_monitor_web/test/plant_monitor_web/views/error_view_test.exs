defmodule PlantMonitorWeb.ErrorViewTest do
  use PlantMonitorWeb.ConnCase
  alias PlantMonitorWeb.Structs.Error.ErrorResponse
  alias PlantMonitorWeb.ErrorView
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(ErrorView, "404.html", []) ==
           "Page not found"
  end

  test "render 500.html" do
    assert render_to_string(ErrorView, "500.html", []) ==
           "Internal server error"
  end

  test "render any other" do
    assert render_to_string(ErrorView, "505.html", []) ==
           "Internal server error"
  end

  # 400 JSON

  test "[ERROR VIEW][400.JSON] Bad request" do
    expected = %ErrorResponse{
      status: 400,
      message: "Bad Request!",
      fields: []
    }

    result = render(ErrorView, "400.json", %{})

    assert expected == result
  end

  # 404 JSON

  test "[ERROR VIEW][404.JSON] Bad request" do
    expected = %ErrorResponse{
      status: 404,
      message: "Not Found!",
      fields: []
    }

    result = render(ErrorView, "404.json", %{})

    assert expected == result
  end

  # ERROR JSON

  test "[ERROR VIEW][ERROR.JSON] Base error" do
    expected = %ErrorResponse{
      status: 422,
      message: "Invalid request parameters. Check our API docs and correct your query.",
      fields: []
    }

    result = render(ErrorView, "error.json", %{})

    assert expected == result
  end

  test "[ERROR VIEW][ERROR.JSON] Custom status in error - 401" do
    expected = %ErrorResponse{
      status: 401,
      message: "No permission to perform this action.",
      fields: []
    }

    result = render(ErrorView, "error.json", %{status: 401})

    assert expected == result
  end

  test "[ERROR VIEW][ERROR.JSON] Custom status in error - 403" do
    expected = %ErrorResponse{
      status: 403,
      message: "Action Forbidden! You must authorize request.",
      fields: []
    }

    result = render(ErrorView, "error.json", %{status: 403})

    assert expected == result
  end

  test "[ERROR VIEW][ERROR.JSON] Custom status in error - 422" do
    expected = %ErrorResponse{
      status: 422,
      message: "Invalid request parameters. Check our API docs and correct your query.",
      fields: []
    }

    result = render(ErrorView, "error.json", %{status: 422})

    assert expected == result
  end

  test "[ERROR VIEW][ERROR.JSON] Custom error" do
    message = "Try again"
    status = 418

    expected = %ErrorResponse{
      status: status,
      message: message,
      fields: []
    }

    result = render(ErrorView, "error.json", %{status: status, message: message})

    assert expected == result
  end

end
