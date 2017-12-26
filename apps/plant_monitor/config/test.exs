use Mix.Config

# Configure your database
config :plant_monitor, PlantMonitor.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "plant_monitor_test",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox
