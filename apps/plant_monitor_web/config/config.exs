# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :plant_monitor_web,
  namespace: PlantMonitorWeb,
  ecto_repos: [PlantMonitor.Repo]

# Configures the endpoint
config :plant_monitor_web, PlantMonitorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RRUJ8t3lakAtmJJuLaV07iSZ6ZphS12Dg7q21xFd+t607LnVPmnfegKTe02OdneQ",
  render_errors: [view: PlantMonitorWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PlantMonitorWeb.PubSub, adapter: Phoenix.PubSub.PG2]

config :plant_monitor_web, :generators,
  context_app: :plant_monitor

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Sentry
config :sentry,
  dsn: "${SENTRY_URL}",
  included_environments: ["production"],
  use_error_logger: true,
  enable_source_code_context: true,
  root_source_code_path: File.cwd!

# Conductor
config :conductor,
  on_auth_failure: :send_resp,
  failure_template: {PlantMonitorWeb.ErrorView, "unauthorized.json"}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
