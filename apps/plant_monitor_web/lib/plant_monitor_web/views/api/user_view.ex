defmodule PlantMonitorWeb.API.UserView do
  @moduledoc """
  User view render.
  """
  use PlantMonitorWeb, :view
  alias PlantMonitorWeb.Structs.ConfirmResponse

  def render("correct_register.json", _assigns) do
    %ConfirmResponse{
      message: "Correct registen in PlantMonitor API. Now you can login and use our API."
    }
  end

end
