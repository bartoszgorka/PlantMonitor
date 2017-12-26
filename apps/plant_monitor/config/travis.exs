use Mix.Config

# Configure your database
config :plant_monitor, PlantMonitor.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "plant_monitor_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
