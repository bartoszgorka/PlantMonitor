defmodule PlantMonitorWeb.API.DeviceView do
  @moduledoc """
  Device view render.
  """
  use PlantMonitorWeb, :view
  alias PlantMonitorWeb.Structs.ConfirmResponse

  def render("correct_register.json", _assigns) do
    %ConfirmResponse{
      message: "We prepare your device correctly."
    }
  end

end
