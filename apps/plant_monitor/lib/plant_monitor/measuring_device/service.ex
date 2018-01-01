defmodule PlantMonitor.DeviceService do
  @moduledoc """
  Service - `PlantMonitor.Device`.
  """
  alias PlantMonitor.MutationAdapter
  alias PlantMonitor.Device
  alias PlantMonitor.Repo
  import Ecto.Query

  @doc """
  Register new measuring device, belong to user.

  ## Parameters
      %{
        user_id :: :uuid,
        name :: String.t(),
        place :: String.t()
      }

  ## Returns
      :ok -> success
      {:error, Ecto.Changeset} -> errors
  """
  @type register_response :: :ok | {:error, %Ecto.Changeset{}}
  @spec register(%{user_id: :uuid, name: String.t(), place: String.t()}) :: register_response
  def register(%{user_id: user_id, name: _name, place: _place} = params) do
    %Device{user_id: user_id}
    |> Device.changeset(params)
    |> Repo.insert()
    |> MutationAdapter.prevent()
  end

  @doc """
  Fetch `PlantMonitor.Device` by Device ID.

  ## Parameters
      device_id :: :uuid

  ## Returns
      nil -> no device found
      PlantMonitor.Device -> on success
  """
  @type fetch_device_response :: %PlantMonitor.Device{} | nil
  @spec fetch_device(device_id :: :uuid) :: fetch_device_response
  def fetch_device(device_id) do
    Repo.get(Device, device_id)
  end

  @doc """
  Get devices registered by user.
  Paginate records from DB.

  ## Parameters
      user_id :: :uuid,
      repo_parameters -> default empty map, you can set "limit" / "page" to custom values

  ## Returns
      %{
        pagination: %{
          page: integer(),
          limit: integer()
        },
        results: list(%PlantMonitor.Device{})
      }
  """
  @type get_devices_response :: %{
    pagination: %{
      page: number(),
      limit: number()
    },
    results: list(%PlantMonitor.Device{})
  }
  @spec get_devices(user_id :: :uuid) :: get_devices_response
  def get_devices(user_id, repo_parameters \\ %{}) do
    Device
    |> where([d], d.user_id == ^user_id)
    |> Repo.paginate(repo_parameters)
  end

  @doc """
  Delete device registered by user.

  ## Parameters
      %{
        user_id :: :uuid,
        device_id :: :uuid
      }

  ## Returns
      :ok -> success
      :error -> invalid request
  """
  @type delete_device_response :: :ok | :error
  @spec delete_device(%{user_id: :uuid, device_id: :uuid}) :: delete_device_response
  def delete_device(%{user_id: user_id, device_id: device_id}) do
    case Ecto.UUID.cast(device_id) do
      :error -> :error
      {:ok, _device_id} -> delete(user_id, device_id)
    end
  end

  @spec delete(user_id :: :uuid, device_id :: :uuid) :: delete_device_response
  defp delete(user_id, device_id) do
    Device
    |> where([d], d.id == ^device_id)
    |> where([d], d.user_id == ^user_id)
    |> Repo.delete_all()
    |> case do
      {1, _result} -> :ok
      _result -> :error
    end
  end

end
