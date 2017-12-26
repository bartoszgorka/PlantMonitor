defmodule PlantMonitor.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :string
      add :encrypted_password, :string

      timestamps()
    end

    create unique_index(:users, [:email], name: :users_email_unique)
  end

end
