defmodule ImageWeb.Router do
  use ImageWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ImageWeb do
    pipe_through :api
  end
end
