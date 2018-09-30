defmodule IssuetrackerWeb.Router do
  use IssuetrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  def get_current_user(conn, _params) do
    # TODO: Move this function out of the router module.
    user_id = get_session(conn, :user_id)
    user = Issuetracker.Accounts.get_user(user_id || -1)
    assign(conn, :current_user, user)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", IssuetrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/tasks", PageController, :tasks

    resources "/users", UserController
    resources "/issues", IssueController


    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", IssuetrackerWeb do
     pipe_through :api
     resources "/times", TimeController, except: [:new, :edit]
  end
end
