defmodule PlantMonitor.OAuth.AccessTokenTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.OAuth.AccessToken

  # CHANGESET

  test "[VALID][CHANGESET] New changeset with AccessToken" do
    user_id = Ecto.UUID.generate()
    parameters = %{
      access_token: "Token",
      permissions: ["plants"]
    }

    changeset =
      %AccessToken{user_id: user_id}
      |> AccessToken.changeset(parameters)

    assert changeset.valid?
  end

  test "[INVALID][CHANGESET] Missing parameters" do
    key_to_drop =
      [:access_token, :permissions]
      |> Enum.random()

    user_id = Ecto.UUID.generate()
    parameters = %{
      access_token: "Token",
      permissions: ["plants"]
    } |> Map.drop([key_to_drop])

    changeset =
      %AccessToken{user_id: user_id}
      |> AccessToken.changeset(parameters)

    refute changeset.valid?
  end

  test "[INVALID][CHANGESET] Duplicated token code" do
    user = insert(:user)
    token = insert(:access_token, %{user_id: user.id})

    parameters = %{
      access_token: token.access_token,
      permissions: token.permissions
    }

    changeset =
      %AccessToken{user_id: user.id}
      |> AccessToken.changeset(parameters)

    result = PlantMonitor.Repo.insert(changeset)
    assert match?({:error, %Ecto.Changeset{}}, result)
  end

end
