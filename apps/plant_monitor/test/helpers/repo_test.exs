defmodule PlantMonitor.RepoTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.User
  alias PlantMonitor.Repo

  # PAGINATE

  test "[PAGINATE] pagination adds current page and limit based on parameters" do
    parameters = %{
      "page" => "3",
      "limit" => "2"
    }
    response = Repo.paginate(User, parameters)
    assert %{results: [], pagination: %{page: 3, limit: 2}} == response
  end

  test "[PAGINATE] pagination adds current page and limit based on parameters - param is int" do
    parameters = %{
      "page" => 1,
      "limit" => 1
    }
    response = Repo.paginate(User, parameters)
    assert %{results: [], pagination: %{page: 1, limit: 1}} == response
  end

  test "[PAGINATE] pagination adds current page and limit based on parameters - default, no parameters" do
    response = Repo.paginate(User, %{})
    assert %{results: [], pagination: %{page: 0, limit: 10}} == response
  end

  test "[PAGINATE] paginate results" do
    insert_list(6, :user)
    parameters = %{
      "page" => "2",
      "limit" => "2"
    }
    response = Repo.paginate(User, parameters)
    assert %{results: response, pagination: %{page: 2, limit: 2}} = response
    assert response |> length == 2
  end

  test "[PAGINATE] pagination Try cast invalid number" do
    parameters = %{
      "page" => "pageNo1",
      "limit" => "LimitPerPage"
    }
    response = Repo.paginate(User, parameters)
    assert %{results: [], pagination: %{page: 0, limit: 10}} == response
  end

  test "[PAGINATE] pagination Not possitive numbers" do
    parameters = %{
      "page" => "-20",
      "limit" => 0
    }
    response = Repo.paginate(User, parameters)
    assert %{results: [], pagination: %{page: 0, limit: 10}} == response
  end

end
