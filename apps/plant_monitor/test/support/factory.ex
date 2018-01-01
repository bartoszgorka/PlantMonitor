defmodule PlantMonitor.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: PlantMonitor.Repo

  # User
  use PlantMonitor.UserFactory
  use PlantMonitor.ProfileFactory

  # OAuth
  use PlantMonitor.OAuth.RefreshTokenFactory

  # Measuring device
  use PlantMonitor.DeviceFactory
  use PlantMonitor.Device.AccessTokenFactory

end
