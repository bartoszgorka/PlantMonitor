defmodule PlantMonitorWeb.ErrorView do
  @moduledoc """
  Error view - Base errors render.
  """
  use PlantMonitorWeb, :view
  alias PlantMonitorWeb.Structs.Error.ErrorResponse

  @error_401_message "No permission to perform this action."
  @error_403_message "Action Forbidden! You must authorize request."
  @error_422_message "Invalid request parameters. Check our API docs and correct your query."

  @doc """
  Render error
  """
  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  # RENDER BASE JSON ERRORS - 400 & 404

  def render("400.json", _params) do
    %ErrorResponse{
      status: 400,
      message: "Bad Request!",
      fields: []
    }
  end

  def render("404.json", _params) do
    %ErrorResponse{
      status: 404,
      message: "Not Found!",
      fields: []
    }
  end

  # RENDER OUR CUSTOM ERROR WITH MESSAGE AND STATUS

  def render("error.json", %{status: status, message: message}) do
    %ErrorResponse{
      status: status,
      message: message,
      fields: []
    }
  end

  # RENDER ERROR WITH DEFAULT MESSAGE FOR SELECTED STATUS

  def render("error.json", %{status: status}) do
    message =
      case status do
        401 -> @error_401_message
        403 -> @error_403_message
        422 -> @error_422_message
      end

    %ErrorResponse{
      status: status,
      message: message,
      fields: []
    }
  end

  # RENDER GLOBAL ERROR JSON

  def render("error.json", _params) do
    %ErrorResponse{
      status: 422,
      message: @error_422_message,
      fields: []
    }
  end

  @doc """
  In case no render clause matches or no template is found, let's render it as 500.
  """
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end

end
