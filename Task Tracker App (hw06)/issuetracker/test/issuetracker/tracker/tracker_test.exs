defmodule Issuetracker.TrackerTest do
  use Issuetracker.DataCase

  alias Issuetracker.Tracker

  describe "issues" do
    alias Issuetracker.Tracker.Issue

    @valid_attrs %{assignor: "some assignor", completed: true, description: "some description", time_taken: "some time_taken", title: "some title"}
    @update_attrs %{assignor: "some updated assignor", completed: false, description: "some updated description", time_taken: "some updated time_taken", title: "some updated title"}
    @invalid_attrs %{assignor: nil, completed: nil, description: nil, time_taken: nil, title: nil}

    def issue_fixture(attrs \\ %{}) do
      {:ok, issue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_issue()

      issue
    end

    test "list_issues/0 returns all issues" do
      issue = issue_fixture()
      assert Tracker.list_issues() == [issue]
    end

    test "get_issue!/1 returns the issue with given id" do
      issue = issue_fixture()
      assert Tracker.get_issue!(issue.id) == issue
    end

    test "create_issue/1 with valid data creates a issue" do
      assert {:ok, %Issue{} = issue} = Tracker.create_issue(@valid_attrs)
      assert issue.assignor == "some assignor"
      assert issue.completed == true
      assert issue.description == "some description"
      assert issue.time_taken == "some time_taken"
      assert issue.title == "some title"
    end

    test "create_issue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_issue(@invalid_attrs)
    end

    test "update_issue/2 with valid data updates the issue" do
      issue = issue_fixture()
      assert {:ok, issue} = Tracker.update_issue(issue, @update_attrs)
      assert %Issue{} = issue
      assert issue.assignor == "some updated assignor"
      assert issue.completed == false
      assert issue.description == "some updated description"
      assert issue.time_taken == "some updated time_taken"
      assert issue.title == "some updated title"
    end

    test "update_issue/2 with invalid data returns error changeset" do
      issue = issue_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_issue(issue, @invalid_attrs)
      assert issue == Tracker.get_issue!(issue.id)
    end

    test "delete_issue/1 deletes the issue" do
      issue = issue_fixture()
      assert {:ok, %Issue{}} = Tracker.delete_issue(issue)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_issue!(issue.id) end
    end

    test "change_issue/1 returns a issue changeset" do
      issue = issue_fixture()
      assert %Ecto.Changeset{} = Tracker.change_issue(issue)
    end
  end

  describe "issues" do
    alias Issuetracker.Tracker.Issue

    @valid_attrs %{assignor: "some assignor", completed: true, description: "some description", time_taken: 42, title: "some title"}
    @update_attrs %{assignor: "some updated assignor", completed: false, description: "some updated description", time_taken: 43, title: "some updated title"}
    @invalid_attrs %{assignor: nil, completed: nil, description: nil, time_taken: nil, title: nil}

    def issue_fixture(attrs \\ %{}) do
      {:ok, issue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_issue()

      issue
    end

    test "list_issues/0 returns all issues" do
      issue = issue_fixture()
      assert Tracker.list_issues() == [issue]
    end

    test "get_issue!/1 returns the issue with given id" do
      issue = issue_fixture()
      assert Tracker.get_issue!(issue.id) == issue
    end

    test "create_issue/1 with valid data creates a issue" do
      assert {:ok, %Issue{} = issue} = Tracker.create_issue(@valid_attrs)
      assert issue.assignor == "some assignor"
      assert issue.completed == true
      assert issue.description == "some description"
      assert issue.time_taken == 42
      assert issue.title == "some title"
    end

    test "create_issue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_issue(@invalid_attrs)
    end

    test "update_issue/2 with valid data updates the issue" do
      issue = issue_fixture()
      assert {:ok, issue} = Tracker.update_issue(issue, @update_attrs)
      assert %Issue{} = issue
      assert issue.assignor == "some updated assignor"
      assert issue.completed == false
      assert issue.description == "some updated description"
      assert issue.time_taken == 43
      assert issue.title == "some updated title"
    end

    test "update_issue/2 with invalid data returns error changeset" do
      issue = issue_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_issue(issue, @invalid_attrs)
      assert issue == Tracker.get_issue!(issue.id)
    end

    test "delete_issue/1 deletes the issue" do
      issue = issue_fixture()
      assert {:ok, %Issue{}} = Tracker.delete_issue(issue)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_issue!(issue.id) end
    end

    test "change_issue/1 returns a issue changeset" do
      issue = issue_fixture()
      assert %Ecto.Changeset{} = Tracker.change_issue(issue)
    end
  end
end
