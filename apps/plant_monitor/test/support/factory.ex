defmodule PlantMonitor.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: PlantMonitor.Repo

  # User
  use PlantMonitor.UserFactory
  use PlantMonitor.ProfileFactory

  # OAuth
  use PlantMonitor.OAuth.AccessTokenFactory
  use PlantMonitor.OAuth.RefreshTokenFactory

end
