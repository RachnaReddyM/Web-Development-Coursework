defmodule Issuetracker.Repo.Migrations.CreateTimes do
  use Ecto.Migration

  def change do
    create table(:times) do
      add :start, :naive_datetime
      add :end, :naive_datetime
      add :issue_id, references(:issues, on_delete: :nothing)

      timestamps()
    end

    create index(:times, [:issue_id])
  end
end
