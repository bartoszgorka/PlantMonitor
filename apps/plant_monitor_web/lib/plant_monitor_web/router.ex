defmodule PlantMonitorWeb.Router do
  use PlantMonitorWeb, :router

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

    resources "/users", UserController, only: [:create]
  end

end
