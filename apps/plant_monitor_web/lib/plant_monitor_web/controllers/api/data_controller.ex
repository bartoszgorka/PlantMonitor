defmodule PlantMonitorWeb.API.DataController do
  @moduledoc """
  Measurement data controller.
  """
  use PlantMonitorWeb, :controller
  alias PlantMonitorWeb.Helpers.MapHelper
  alias PlantMonitorWeb.API.DataView
  alias PlantMonitor.DataService

  @doc """
  Insert new measurement data.
  """
  def create(%{assigns: %{device_id: _device_id} = device_id_map} = conn, parameters) do
    parameters
    |> MapHelper.string_keys_to_atoms()
    |> Map.merge(device_id_map)
    |> DataService.insert_data()
    |> case do
      :ok ->
        conn
        |> put_status(201)
        |> render(DataView, "confirm_insert.json", %{})
      {:error, changeset} ->
        conn
        |> PlantMonitorWeb.ErrorRequest.invalid_request(changeset)
    end
  end

end
