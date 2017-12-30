use Mix.Config

config :plant_monitor, PlantMonitor.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  pool_size: 10

config :plant_monitor,
  private_key: "${PRIVATE_KEY}",
  public_key: "${PUBLIC_KEY}"
