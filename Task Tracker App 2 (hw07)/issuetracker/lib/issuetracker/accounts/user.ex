defmodule Issuetracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Issuetracker.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :manager_id, :integer
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :manager_id])
    |> validate_required([:name, :email])
  end
end
