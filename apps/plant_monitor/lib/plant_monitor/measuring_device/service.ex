defmodule PlantMonitor.DeviceService do
  @moduledoc """
  Service - `PlantMonitor.Device`.
  """
  alias PlantMonitor.MutationAdapter
  alias PlantMonitor.Device
  alias PlantMonitor.Repo

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

end
