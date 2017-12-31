defmodule PlantMonitor.ProfileService do
  @moduledoc """
  Service user for `PlantMonitor.Profile` structure.
  """
  alias PlantMonitor.Profile

  def prepare_register_changeset(%{user_id: user_id} = params) do
    %Profile{user_id: user_id}
    |> Profile.changeset(params)
  end

end
