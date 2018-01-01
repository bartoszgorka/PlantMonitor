defmodule PlantMonitorWeb.Plugs.SplitTokenClaims do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _params \\ %{}) do
    conn
    |> assign_user_id()
    |> assign_scopes()
  end

  defp assign_user_id(conn) do
    user_id = conn.assigns.claims.user_id

    conn
    |> assign(:user_id, user_id)
  end

  defp assign_scopes(conn) do
    scopes = conn.assigns.claims.permissions

    conn
    |> assign(:scopes, scopes)
  end

end
