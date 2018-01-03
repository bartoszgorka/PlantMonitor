defmodule PlantMonitorWeb.Router do
  use PlantMonitorWeb, :router
  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :assign_access_token do
    plug PlantMonitorWeb.Plugs.AssignAccessToken
  end

  pipeline :api_authorize do
    plug PlantMonitorWeb.Plugs.ValidateAccessToken
    plug PlantMonitorWeb.Plugs.SplitTokenClaims
  end

  pipeline :api_sensor_authorize do
    plug PlantMonitorWeb.Plugs.ValidateSensorRequest
  end

  scope "/", PlantMonitorWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/oauth", PlantMonitorWeb.OAuth do
    pipe_through [:api, :assign_access_token]

    post "/token", AuthorizeController, :refresh_token
  end

  scope "/api", PlantMonitorWeb.API do
    pipe_through :api

    post "/users", UserController, :register
    post "/login", SessionController, :login
  end

  scope "/api", PlantMonitorWeb.API do
    pipe_through [:api, :api_authorize]

    resources "/devices", DeviceController
  end

  scope "/api", PlantMonitorWeb.API do
    pipe_through [:api, :api_sensor_authorize]

    resources "/measurement_data", DataController
  end

  scope "/api" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :plant_monitor_web, swagger_file: "api_docs.json", disable_validator: true
  end

  def swagger_info do %{
      info: %{
        version: PlantMonitorWeb.Mixfile.version(),
        title: "PlantMonitor API"
      }
    }
  end

end
