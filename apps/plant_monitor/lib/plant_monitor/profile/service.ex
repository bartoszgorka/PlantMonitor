defmodule PlantMonitor.ProfileService do
  @moduledoc """
  Service user for `PlantMonitor.Profile` structure.
  """
  alias PlantMonitor.Profile

  @doc """
  Prepare profile register changeset.

  ## Reguired parameters
      %{
        user_id :: :uuid
      }

  ## Returns
      Ecto.Changeset structure with Profile's changeset
  """
  @spec prepare_register_changeset(%{user_id: :uuid}) :: %Ecto.Changeset{}
  def prepare_register_changeset(%{user_id: user_id} = params) do
    %Profile{user_id: user_id}
    |> Profile.changeset(params)
  end

end
