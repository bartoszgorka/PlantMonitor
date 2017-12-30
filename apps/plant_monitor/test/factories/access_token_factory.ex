defmodule PlantMonitor.OAuth.AccessTokenFactory do
  @moduledoc """
  `PlantMonitor.OAuth.AccessToken` schema factory.
  """

  defmacro __using__(_opts) do
    quote do

      def access_token_factory do
        %PlantMonitor.OAuth.AccessToken{
          access_token: sequence("AccessToken"),
          permissions: ["plants"]
        }
      end
    end
  end

end
