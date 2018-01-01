defmodule PlantMonitorWeb.API.RepoViewTest do
  use PlantMonitorWeb.ConnCase
  alias PlantMonitorWeb.API.RepoView

  # PREPARE REPO PAGINATION DETAILS

  test "[REPO VIEW][RENDER_PAGINATION] Render repo pagination details" do
    correct = %PlantMonitorWeb.Structs.Repo.Pagination{
      limit: 15,
      page: 0
    }
    parameters = %{pagination: %{limit: 15, page: 0}, results: []}

    result = RepoView.render_pagination(parameters)
    assert correct == result
  end

end
