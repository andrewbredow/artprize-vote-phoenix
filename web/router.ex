defmodule Artprize.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Artprize do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/vote", VoteController, :index
    post "/vote", VoteController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", Artprize do
  #   pipe_through :api
  # end
end
