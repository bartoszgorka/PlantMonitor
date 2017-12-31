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

end
