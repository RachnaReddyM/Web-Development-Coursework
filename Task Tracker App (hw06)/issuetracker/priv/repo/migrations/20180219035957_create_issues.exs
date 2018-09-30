defmodule Issuetracker.Repo.Migrations.CreateIssues do
  use Ecto.Migration

  def change do
    create table(:issues) do
      add :title, :text, null: false
      add :description, :text, null: false
      add :assignor, :string, null: false
      add :completed, :boolean, default: false, null: false
      add :time_taken, :integer, default: 0
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:issues, [:user_id])
  end
end
