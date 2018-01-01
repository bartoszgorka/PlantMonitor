defmodule PlantMonitorWeb.Structs.Repo.Pagination do
  @moduledoc """
  Repo pagination details.
  """

  @enforce_keys [:limit, :page]
  defstruct [:limit, :page]

end
