defmodule PlantMonitorWeb.ErrorRequest do
  @moduledoc """
  Helper for prepare response on invalid requests.
  """
  use PlantMonitorWeb, :controller
  alias PlantMonitorWeb.ErrorView

  @doc false
  def invalid_request(conn) do
    conn
    |> put_status(422)
    |> render(ErrorView, "error.json", %{})
  end

  @doc """
  Render custom response on invalid request.
  As response HTTP Status render given status with custom message.
  """
  def invalid_request(conn, %{status: status, message: message}) do
    conn
    |> put_status(status)
    |> render(ErrorView, "error.json", %{status: status, message: message})
  end

  @doc """
  Render custom response on invalid request.
  As response HTTP Status render given status.
  """
  def invalid_request(conn, %{status: status}) do
    conn
    |> put_status(status)
    |> render(ErrorView, "error.json", %{status: status})
  end

  @doc """
  Send invalid Ecto.Changeset to render errors.
  """
  def invalid_request(conn, %Ecto.Changeset{} = changeset) do
    conn
    |> put_status(422)
    |> render(ErrorView, "error.json", changeset)
  end

end
