defmodule IssuetrackerWeb.IssueControllerTest do
  use IssuetrackerWeb.ConnCase

  alias Issuetracker.Tracker

  @create_attrs %{assignor: "some assignor", completed: true, description: "some description", time_taken: 42, title: "some title"}
  @update_attrs %{assignor: "some updated assignor", completed: false, description: "some updated description", time_taken: 43, title: "some updated title"}
  @invalid_attrs %{assignor: nil, completed: nil, description: nil, time_taken: nil, title: nil}

  def fixture(:issue) do
    {:ok, issue} = Tracker.create_issue(@create_attrs)
    issue
  end

  describe "index" do
    test "lists all issues", %{conn: conn} do
      conn = get conn, issue_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Issues"
    end
  end

  describe "new issue" do
    test "renders form", %{conn: conn} do
      conn = get conn, issue_path(conn, :new)
      assert html_response(conn, 200) =~ "New Issue"
    end
  end

  describe "create issue" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, issue_path(conn, :create), issue: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == issue_path(conn, :show, id)

      conn = get conn, issue_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Issue"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, issue_path(conn, :create), issue: @invalid_attrs
      assert html_response(conn, 200) =~ "New Issue"
    end
  end

  describe "edit issue" do
    setup [:create_issue]

    test "renders form for editing chosen issue", %{conn: conn, issue: issue} do
      conn = get conn, issue_path(conn, :edit, issue)
      assert html_response(conn, 200) =~ "Edit Issue"
    end
  end

  describe "update issue" do
    setup [:create_issue]

    test "redirects when data is valid", %{conn: conn, issue: issue} do
      conn = put conn, issue_path(conn, :update, issue), issue: @update_attrs
      assert redirected_to(conn) == issue_path(conn, :show, issue)

      conn = get conn, issue_path(conn, :show, issue)
      assert html_response(conn, 200) =~ "some updated assignor"
    end

    test "renders errors when data is invalid", %{conn: conn, issue: issue} do
      conn = put conn, issue_path(conn, :update, issue), issue: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Issue"
    end
  end

  describe "delete issue" do
    setup [:create_issue]

    test "deletes chosen issue", %{conn: conn, issue: issue} do
      conn = delete conn, issue_path(conn, :delete, issue)
      assert redirected_to(conn) == issue_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, issue_path(conn, :show, issue)
      end
    end
  end

  defp create_issue(_) do
    issue = fixture(:issue)
    {:ok, issue: issue}
  end
end
