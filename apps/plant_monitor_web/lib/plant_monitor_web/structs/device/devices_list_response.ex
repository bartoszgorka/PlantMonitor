defmodule PlantMonitorWeb.Structs.Device.DevicesListResponse do
  @moduledoc """
  Devices list response.
  """

  @enforce_keys [:pagination, :devices]
  defstruct [:pagination, :devices]

end
