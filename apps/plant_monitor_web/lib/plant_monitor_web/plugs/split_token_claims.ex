defmodule PlantMonitorWeb.Plugs.SplitTokenClaims do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _params \\ %{}) do
    conn
    |> assign_user_id()
    |> assign_permissions()
  end

  defp assign_user_id(conn) do
    user_id = conn.assigns.claims.user_id

    conn
    |> assign(:user_id, user_id)
  end

  defp assign_permissions(conn) do
    permissions = conn.assigns.claims.permissions

    conn
    |> assign(:permissions, permissions)
  end

end
