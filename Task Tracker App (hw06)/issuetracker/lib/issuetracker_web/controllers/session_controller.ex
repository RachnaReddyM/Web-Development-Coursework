defmodule IssuetrackerWeb.SessionController do
  use IssuetrackerWeb, :controller

  alias Issuetracker.Accounts
  alias Issuetracker.Accounts.User

  def create(conn, %{"email" => email}) do
    user = Accounts.get_user_by_email(email)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Hello #{user.name} !")
      |> redirect(to: "/tasks")
    else
      conn
      |> put_flash(:error, "Login Failed. Try again with registered Email ID.")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
