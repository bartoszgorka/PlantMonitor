defmodule PlantMonitor.Repo.Migrations.CreateAccessTokensTable do
  use Ecto.Migration

  def change do
    create table(:access_tokens, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all)

      add :access_token, :string
      add :permissions, {:array, :string}

      timestamps()
    end

    create unique_index(:access_tokens, :access_token, name: :access_token_unique)
  end

end
