defmodule PlantMonitorWeb.Structs.Device.Device do
  @moduledoc """
  Single device structure.
  """

  @enforce_keys [:id, :name, :place]
  defstruct [:id, :name, :place]

end
