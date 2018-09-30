defmodule Issuetracker.Tracker.Issue do
  use Ecto.Schema
  import Ecto.Changeset
  alias Issuetracker.Tracker.Issue


  schema "issues" do
    #name of the assignor
    field :assignor, :string

    #task completion status
    field :completed, :boolean, default: false

    #description of the task
    field :description, :string

    #time_taken task completion
    field :time_taken, :integer, default: 0

    #title of the task
    field :title, :string

    #userid of the assignee
    #field :user_id, :id
    belongs_to :user, Issuetracker.Accounts.User
    has_many :times, Issuetracker.Tracker.Time

    timestamps()
  end

  @doc false
  def changeset(%Issue{} = issue, attrs) do
    issue
    |> cast(attrs, [:title, :description, :assignor, :completed, :time_taken, :user_id])
    |> validate_required([:title, :description, :assignor, :completed, :time_taken, :user_id])
  end
end
