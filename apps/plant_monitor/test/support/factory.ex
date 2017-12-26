defmodule PlantMonitor.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: PlantMonitor.Repo

  # User
  use PlantMonitor.UserFactory

end
