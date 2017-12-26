defmodule PlantMonitorWeb.PageController do
  use PlantMonitorWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
