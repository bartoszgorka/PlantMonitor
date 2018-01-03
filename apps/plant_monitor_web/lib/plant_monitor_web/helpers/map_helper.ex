defmodule PlantMonitorWeb.Helpers.MapHelper do
  @moduledoc """
  Map helper in `PlantMonitor` application.
  """

  @doc """
  Parse string keys in map to atoms

  ## Parameters
      map()

  ## Returns
      map() with atoms as keys
  """
  @spec string_keys_to_atoms(map()) :: map()
  def string_keys_to_atoms(map) when is_map(map) do
    map
    |> Map.new(fn {k, v} ->
      {String.to_atom(k), v}
    end)
  end

end
