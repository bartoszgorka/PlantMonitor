defmodule PlantMonitor.Repo.Migrations.CreateRefreshTokensTable do
  use Ecto.Migration

  def change do
    create table(:refresh_tokens, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all)

      add :refresh_token, :string
      add :secret_code, :string

      timestamps()
    end

    create unique_index(:refresh_tokens, [:refresh_token, :secret_code], name: :refresh_token_unique)
  end

end
