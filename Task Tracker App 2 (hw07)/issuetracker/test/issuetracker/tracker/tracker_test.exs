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

  describe "timeblocks" do
    alias Issuetracker.Tracker.Timeblock

    @valid_attrs %{end: ~N[2010-04-17 14:00:00.000000], start: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01.000000], start: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{end: nil, start: nil}

    def timeblock_fixture(attrs \\ %{}) do
      {:ok, timeblock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_timeblock()

      timeblock
    end

    test "list_timeblocks/0 returns all timeblocks" do
      timeblock = timeblock_fixture()
      assert Tracker.list_timeblocks() == [timeblock]
    end

    test "get_timeblock!/1 returns the timeblock with given id" do
      timeblock = timeblock_fixture()
      assert Tracker.get_timeblock!(timeblock.id) == timeblock
    end

    test "create_timeblock/1 with valid data creates a timeblock" do
      assert {:ok, %Timeblock{} = timeblock} = Tracker.create_timeblock(@valid_attrs)
      assert timeblock.end == ~N[2010-04-17 14:00:00.000000]
      assert timeblock.start == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_timeblock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_timeblock(@invalid_attrs)
    end

    test "update_timeblock/2 with valid data updates the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, timeblock} = Tracker.update_timeblock(timeblock, @update_attrs)
      assert %Timeblock{} = timeblock
      assert timeblock.end == ~N[2011-05-18 15:01:01.000000]
      assert timeblock.start == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_timeblock/2 with invalid data returns error changeset" do
      timeblock = timeblock_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_timeblock(timeblock, @invalid_attrs)
      assert timeblock == Tracker.get_timeblock!(timeblock.id)
    end

    test "delete_timeblock/1 deletes the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, %Timeblock{}} = Tracker.delete_timeblock(timeblock)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_timeblock!(timeblock.id) end
    end

    test "change_timeblock/1 returns a timeblock changeset" do
      timeblock = timeblock_fixture()
      assert %Ecto.Changeset{} = Tracker.change_timeblock(timeblock)
    end
  end

  describe "times" do
    alias Issuetracker.Tracker.Time

    @valid_attrs %{end: ~N[2010-04-17 14:00:00.000000], start: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01.000000], start: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{end: nil, start: nil}

    def time_fixture(attrs \\ %{}) do
      {:ok, time} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_time()

      time
    end

    test "list_times/0 returns all times" do
      time = time_fixture()
      assert Tracker.list_times() == [time]
    end

    test "get_time!/1 returns the time with given id" do
      time = time_fixture()
      assert Tracker.get_time!(time.id) == time
    end

    test "create_time/1 with valid data creates a time" do
      assert {:ok, %Time{} = time} = Tracker.create_time(@valid_attrs)
      assert time.end == ~N[2010-04-17 14:00:00.000000]
      assert time.start == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_time(@invalid_attrs)
    end

    test "update_time/2 with valid data updates the time" do
      time = time_fixture()
      assert {:ok, time} = Tracker.update_time(time, @update_attrs)
      assert %Time{} = time
      assert time.end == ~N[2011-05-18 15:01:01.000000]
      assert time.start == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_time/2 with invalid data returns error changeset" do
      time = time_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_time(time, @invalid_attrs)
      assert time == Tracker.get_time!(time.id)
    end

    test "delete_time/1 deletes the time" do
      time = time_fixture()
      assert {:ok, %Time{}} = Tracker.delete_time(time)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_time!(time.id) end
    end

    test "change_time/1 returns a time changeset" do
      time = time_fixture()
      assert %Ecto.Changeset{} = Tracker.change_time(time)
    end
  end
end
