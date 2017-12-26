use Mix.Config

config :plant_monitor,
  ecto_repos: [PlantMonitor.Repo]

import_config "#{Mix.env}.exs"
