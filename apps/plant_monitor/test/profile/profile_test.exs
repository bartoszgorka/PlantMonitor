defmodule PlantMonitor.ProfileTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.Profile

  # CHANGESET

  test "[VALID][CHANGESET] New changeset with Profile" do
    parameters = %{
      first_name: "John",
      last_name: "Example"
    }

    changeset =
      %Profile{}
      |> Profile.changeset(parameters)

    assert changeset.valid?
  end

  test "[INVALID][CHANGESET] Missing parameters" do
    key_to_drop =
      [:first_name, :last_name]
      |> Enum.random()

    parameters = %{
      first_name: "John",
      last_name: "Example"
    } |> Map.drop([key_to_drop])

    changeset =
      %Profile{}
      |> Profile.changeset(parameters)

    refute changeset.valid?
  end

  test "[INVALID][CHANGESET] Duplicated user" do
    user = insert(:user)
    _profile = PlantMonitor.Repo.insert!(%Profile{user_id: user.id})

    parameters = %{
      first_name: "John",
      last_name: "Example"
    }

    changeset =
      %Profile{user_id: user.id}
      |> Profile.changeset(parameters)

    result = PlantMonitor.Repo.insert(changeset)
    assert match?({:error, %Ecto.Changeset{}}, result)
  end

end
