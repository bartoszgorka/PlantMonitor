defmodule PlantMonitor.Repo do
  @moduledoc false
  use Ecto.Repo, otp_app: :plant_monitor
  import Ecto.Query, only: [offset: 2, limit: 2]

  @default_limit 10

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  @doc """
  Returns paginated query results by page and limit params.
  @default_limit 10
  """
  @spec paginate(query :: Ecto.Query.t, map()) :: map()
  def paginate(query, params) do
    limit = get_limit(params["limit"])
    page = get_page(params["page"])

    %{
      results: apply_pagination(query, limit, page),
      pagination: %{
        limit: limit,
        page: page
      }
    }
  end

  defp get_limit(nil),   do: @default_limit
  defp get_limit(limit) when is_binary(limit), do: String.to_integer(limit)
  defp get_limit(limit), do: limit

  defp get_page(nil),  do: 0
  defp get_page(page) when is_binary(page), do: String.to_integer(page)
  defp get_page(page), do: page

  defp apply_pagination(query, limit, page) do
    offset = limit * page
    query
    |> offset(^offset)
    |> limit(^limit)
    |> all()
  end

end
