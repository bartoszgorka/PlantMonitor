defmodule PlantMonitorWeb.Structs.OAuth.TokenResponse do
  @moduledoc """
  Structure used in return OAuth access token details
  """

  @enforce_keys [:access_token, :token_type, :permissions, :expires_in, :refresh_token]
  defstruct [:access_token, :token_type, :permissions, :expires_in, :refresh_token]

end
