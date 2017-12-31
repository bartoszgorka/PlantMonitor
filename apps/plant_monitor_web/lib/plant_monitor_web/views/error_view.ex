defmodule PlantMonitorWeb.ErrorView do
  @moduledoc """
  Error view - Base errors render.
  """
  use PlantMonitorWeb, :view
  alias PlantMonitorWeb.Structs.Error.ErrorResponse

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

  @doc """
  In case no render clause matches or no template is found, let's render it as 500.
  """
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end

end
