defmodule PlantMonitor.Repo.Migrations.AddPermissionsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :permissions, {:array, :string}
    end
  end
end
