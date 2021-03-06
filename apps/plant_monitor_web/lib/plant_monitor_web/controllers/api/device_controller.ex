defmodule PlantMonitorWeb.API.DeviceController do
  @moduledoc """
  Measuring device controller.
  """
  use Conductor
  use PlantMonitorWeb, :controller
  alias PlantMonitor.DeviceService
  alias PlantMonitorWeb.ErrorRequest
  alias PlantMonitorWeb.API.DeviceView

  @doc """
  Prepare list with created measuring devices.
  Authorized - "devices:listing"
  """
  @authorize scope: "devices:listing"
  def index(%{assigns: %{user_id: user_id}} = conn, parameters) do
    results = DeviceService.get_devices(user_id, parameters)

    conn
    |> render(DeviceView, "devices_list.json", results)
  end

  @doc """
  Register new measuring device.
  Authorized - "devices:create"

  ## Parameters
      "name" :: String.t()
      "place" :: String.t()
  """
  @authorize scope: "devices:create"
  def create(%{assigns: %{user_id: user_id}} = conn, %{"name" => name, "place" => place}) do
    device_details = %{
      user_id: user_id,
      name: name,
      place: place
    }

    case DeviceService.register(device_details) do
      :ok ->
        conn
        |> put_status(201)
        |> render(DeviceView, "correct_register.json", %{})
      {:error, changeset} ->
        conn
        |> ErrorRequest.invalid_request(changeset)
    end
  end
  def create(conn, _parameters), do: ErrorRequest.invalid_request(conn, %{status: 422})

end
