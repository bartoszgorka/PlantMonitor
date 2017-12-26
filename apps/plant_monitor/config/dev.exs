use Mix.Config

# Configure your database
config :plant_monitor, PlantMonitor.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "plant_monitor_dev",
  hostname: "localhost",
  pool_size: 10
