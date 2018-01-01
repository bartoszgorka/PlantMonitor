defmodule PlantMonitorWeb.API.RepoView do
  @moduledoc """
  Repo helper view.
  """
  alias PlantMonitorWeb.Structs.Repo.Pagination

  def render_pagination(%{pagination: %{limit: limit, page: page}}) do
    %Pagination{
      limit: limit,
      page: page
    }
  end

end
