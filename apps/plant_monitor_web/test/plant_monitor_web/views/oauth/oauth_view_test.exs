defmodule PlantMonitorWeb.OAuthViewTest do
  use PlantMonitorWeb.ConnCase
  alias PlantMonitorWeb.OAuthView

  # RENDER ACCESS TOKEN JSON

  test "[OAUTH VIEW][ACCESS_TOKEN.JSON] Base structure with access_token" do
    parameters = %{
      access_token: "access_token_code",
      expires_in: 3600,
      permissions: ["plants", "users"],
      refresh_token: "refresh_token_code"
    }

    correct = %PlantMonitorWeb.Structs.OAuth.TokenResponse{
      expires_in: parameters.expires_in,
      permissions: parameters.permissions,
      token_type: "Bearer",
      access_token: parameters.access_token,
      refresh_token: parameters.refresh_token
    }

    result = Phoenix.View.render(OAuthView,  "access_token.json", parameters)
    assert correct == result
  end

end
