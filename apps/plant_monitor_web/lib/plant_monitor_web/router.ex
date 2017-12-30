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

  scope "/", PlantMonitorWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", PlantMonitorWeb.API do
    pipe_through :api

    post "/users", UserController, :create
    post "/login", SessionController, :login
  end

end
