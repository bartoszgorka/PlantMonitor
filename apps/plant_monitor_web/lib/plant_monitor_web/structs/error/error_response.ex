defmodule PlantMonitorWeb.Structs.Error.ErrorResponse do
  @moduledoc """
  Error response - invalid requests.
  """

  @enforce_keys [:status, :message]
  defstruct [:status, :message, fields: []]

end
