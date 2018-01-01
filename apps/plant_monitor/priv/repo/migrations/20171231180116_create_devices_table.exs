defmodule PlantMonitor.Repo.Migrations.CreateDevicesTable do
  use Ecto.Migration

  def change do
    create table(:devices, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all)

      add :name, :string
      add :place, :string

      timestamps()
    end

    create unique_index(:devices, [:user_id, :name], name: :devices_name_unique)
  end

end
