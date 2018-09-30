defmodule Issuetracker.Tracker.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Issuetracker.Tracker.Timeblock


  schema "timeblocks" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :issue, Issuetracker.Tracker.Issue

    timestamps()
  end

  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
