defmodule PlantMonitor.Repo.Migrations.CreateAccessTokens do
  use Ecto.Migration

  def change do
    create table(:access_tokens, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :device_id, references(:devices, type: :uuid, on_delete: :delete_all)
      add :access_token, :string

      timestamps()
    end

    create unique_index(:access_tokens, :access_token, name: :access_token_unique)
  end

end
