defmodule PlantMonitor.Repo.Migrations.CreateProfileTable do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all)
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end

    create unique_index(:profiles, :user_id, name: :profile_user_id_unique)
  end

end
