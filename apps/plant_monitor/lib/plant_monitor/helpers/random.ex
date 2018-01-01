defmodule PlantMonitor.Random do
  @moduledoc """
  Random secury tokens in PlantMonitor API.
  """

  @doc """
  Random secury keys.
  Default length -> 20 characster

  ## Parameters (optional)
      key_length :: integer()

  ## Returns
      key :: String.t()
  """
  def random_key(n \\ 20) do
    :crypto.strong_rand_bytes(n)
    |> Base.encode64(case: :lower, padding: true)
    |> String.slice(0, n)
  end

end
