defmodule PlantMonitor.OAuth.RefreshTokenFactory do
  @moduledoc """
  `PlantMonitor.OAuth.RefreshToken` schema factory.
  """

  defmacro __using__(_opts) do
    quote do

      def refresh_token_factory do
        %PlantMonitor.OAuth.RefreshToken{
          refresh_token: sequence("refresh_token_"),
          secret_code: sequence("secret_code_")
        }
      end
    end
  end

end
