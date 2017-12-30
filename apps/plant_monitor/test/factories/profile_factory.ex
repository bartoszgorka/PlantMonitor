defmodule PlantMonitor.ProfileFactory do
  @moduledoc """
  `PlantMonitor.Profile` schema factory.
  """

  defmacro __using__(_opts) do
    quote do

      def profile_factory do
        %PlantMonitor.Profile{
          first_name: sequence("John"),
          last_name: sequence("Example")
        }
      end
    end
  end

end
