defmodule PlantMonitorWeb.Plugs.ValidateAccessToken do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _params \\ %{}) do
    conn
    |> assign_token_claims()
  end

  defp assign_token_claims(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, claims}        <- PlantMonitor.OAuth.verify_token(token)
    do
      assign(conn, :claims, claims)
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
