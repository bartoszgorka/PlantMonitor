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

end
