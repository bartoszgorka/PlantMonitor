defmodule PlantMonitorWebWeb.PageController do
  use PlantMonitorWebWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
