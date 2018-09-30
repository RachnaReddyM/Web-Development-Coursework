defmodule Issuetracker.Tracker.Time do
  use Ecto.Schema
  import Ecto.Changeset
  alias Issuetracker.Tracker.Time


  schema "times" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :issue, Issuetracker.Tracker.Issue

    timestamps()
  end

  @doc false
  def changeset(%Time{} = time, attrs) do
    time
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
