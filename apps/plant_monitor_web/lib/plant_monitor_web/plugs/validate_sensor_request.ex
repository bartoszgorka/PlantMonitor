defmodule PlantMonitorWeb.Plugs.ValidateSensorRequest do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _params \\ %{}) do
    conn
    |> assign_device_id()
  end

  defp assign_device_id(conn) do
    with ["Basic " <> token]      <- get_req_header(conn, "authorization"),
         %{device_id: device_id}  <- PlantMonitor.Device.AccessTokenService.fetch_by_token(token)
    do
      assign(conn, :device_id, device_id)
    else
      _ -> unauthorized!(conn)
    end
  end

  defp unauthorized!(conn) do
    conn
    |> put_status(401)
    |> Phoenix.Controller.render(PlantMonitorWeb.ErrorView, "unauthorized.json", %{})
    |> halt()
  end

end
