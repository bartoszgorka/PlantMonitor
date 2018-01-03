defmodule PlantMonitorWeb.API.DataView do
  @moduledoc """
  Measurement data view render.
  """
  use PlantMonitorWeb, :view
  alias PlantMonitorWeb.Structs.ConfirmResponse

  def render("confirm_insert.json", _assigns) do
    %ConfirmResponse{
      message: "We inserted your measurement data."
    }
  end

end
