defmodule PlantMonitorWeb.Structs.Error.ErrorField do
  @moduledoc """
  Error field - single invalid parameter
  """

  @enforce_keys [:key, :message]
  defstruct [:key, :message]

end
