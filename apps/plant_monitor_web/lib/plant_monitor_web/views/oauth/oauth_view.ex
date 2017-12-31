defmodule PlantMonitorWeb.OAuthView do
  @moduledoc """
  OAuth modules views render.
  """
  use PlantMonitorWeb, :view
  alias PlantMonitorWeb.Structs.OAuth.TokenResponse

  def render("access_token.json", details) do
    %TokenResponse {
      expires_in: details.expires_in,
      permissions: details.permissions,
      token_type: "Bearer",
      access_token: details.access_token,
      refresh_token: details.refresh_token
    }
  end

end
