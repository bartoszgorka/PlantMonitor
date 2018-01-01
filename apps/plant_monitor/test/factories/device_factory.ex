defmodule PlantMonitor.DeviceFactory do
  @moduledoc """
  `PlantMonitor.Device` schema factory.
  """

  defmacro __using__(_opts) do
    quote do

      def device_factory do
        %PlantMonitor.Device{
          name: sequence("Measuring device #"),
          place: sequence("HomePlace")
        }
      end
    end
  end

end
