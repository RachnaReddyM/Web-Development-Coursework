defmodule IssuetrackerWeb.PageController do
  use IssuetrackerWeb, :controller

  alias Issuetracker.Tracker
  alias Issuetracker.Tracker.Issue
  alias Issuetracker.Accounts
  alias Issuetracker.Accounts.User

  def index(conn, _params) do
    render conn, "index.html"
  end

  def tasks(conn, _params) do
  issues = Issuetracker.Tracker.list_issues()
  users = Accounts.list_users()
  task_up = %Issue{ user_id: conn.assigns[:current_user].id}
  changeset = Issuetracker.Tracker.change_issue(task_up)
  render conn, "tasks.html", issues: issues, changeset: changeset
  end
end
