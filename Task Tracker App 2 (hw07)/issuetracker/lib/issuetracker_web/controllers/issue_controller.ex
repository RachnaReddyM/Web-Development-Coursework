defmodule IssuetrackerWeb.IssueController do
  use IssuetrackerWeb, :controller

  alias Issuetracker.Tracker
  alias Issuetracker.Tracker.Issue
  alias Issuetracker.Accounts
  alias Issuetracker.Accounts.User

  def index(conn, _params) do
    issues = Tracker.list_issues()
    render(conn, "index.html", issues: issues)
  end

  def new(conn, _params) do
    c_user = %Issue{assignor: conn.assigns[:current_user].name}
    current_user = conn.assigns[:current_user]
    changeset = Tracker.change_issue(c_user)
    users = Accounts.list_users()
    render(conn, "new.html", changeset: changeset, users: users, current_user: current_user)
  end

  def create(conn, %{"issue" => issue_params}) do
    users = Accounts.list_users()
    case Tracker.create_issue(issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Task added successfully.")
        |> redirect(to: issue_path(conn, :show, issue))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    issue = Tracker.get_issue!(id)
    times=Tracker.list_times()
    IO.inspect(times)
    render(conn, "show.html", issue: issue, times: times)
  end

  def edit(conn, %{"id" => id}) do
    issue = Tracker.get_issue!(id)
    changeset = Tracker.change_issue(issue)
    users = Accounts.list_users()
    current_user = conn.assigns[:current_user]
    render(conn, "edit.html", issue: issue, changeset: changeset, users: users, current_user: current_user)
  end

  def update(conn, %{"id" => id, "issue" => issue_params}) do
    users = Accounts.list_users()
    issue = Tracker.get_issue!(id)
    current_user = conn.assigns[:current_user]
    case Tracker.update_issue(issue, issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: issue_path(conn, :show, issue))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", issue: issue, changeset: changeset, users: users, current_user: current_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    issue = Tracker.get_issue!(id)
    {:ok, _issue} = Tracker.delete_issue(issue)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: page_path(conn, :tasks))
  end
end
