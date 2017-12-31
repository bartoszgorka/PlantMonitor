defmodule PlantMonitorWeb.Plugs.AssignAccessToken do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _params \\ %{}) do
    conn
    |> assign_access_token()
  end

  defp assign_access_token(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> assign(conn, :access_token, token)
      _ -> conn
    end
  end

end
