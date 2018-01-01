defmodule PlantMonitor.DataService do
  @moduledoc """
  `PlantMonitor.Data` service.
  """
  alias PlantMonitor.MutationAdapter
  alias PlantMonitor.Data
  alias PlantMonitor.Repo

  @doc """
  Insert new measure data to database.

  ## Required parameter
      %{
        device_id :: :uuid
      }

  ## Returns
      :ok -> success
      {:error, Ecto.Changeset} -> error in insert action
  """
  @type insert_data_response :: :ok | {:error, %Ecto.Changeset{}}
  @spec insert_data(%{device_id: :uuid}) :: insert_data_response
  def insert_data(%{device_id: device_id} = params) do
    %Data{device_id: device_id}
    |> Data.changeset(params)
    |> Repo.insert()
    |> MutationAdapter.prevent()
  end

end
