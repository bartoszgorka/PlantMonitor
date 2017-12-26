defmodule PlantMonitor.Application do
  @moduledoc false

  use Application
  import Supervisor.Spec

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      supervisor(PlantMonitor.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: PlantMonitor.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
