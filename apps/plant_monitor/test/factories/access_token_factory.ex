defmodule PlantMonitor.Device.AccessTokenFactory do
  @moduledoc """
  `PlantMonitor.Device.AccessToken` schema factory.
  """

  defmacro __using__(_opts) do
    quote do

      def access_token_factory do
        %PlantMonitor.Device.AccessToken{
          access_token: sequence("Device access_token")
        }
      end
    end
  end

end
