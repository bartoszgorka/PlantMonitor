defmodule PlantMonitor.OAuth.RefreshTokenTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.OAuth.RefreshToken

  # CHANGESET

  test "[VALID][CHANGESET] New changeset with refresh token" do
    user_id = Ecto.UUID.generate()
    parameters = %{
      refresh_token: "refresh_token",
      secret_code: "secret"
    }

    changeset =
      %RefreshToken{user_id: user_id}
      |> RefreshToken.changeset(parameters)

    assert changeset.valid?
  end

  test "[INVALID][CHANGESET] Missing parameters" do
    key_to_drop =
      [:refresh_token, :secret_code]
      |> Enum.random()

    user_id = Ecto.UUID.generate()
    parameters = %{
      refresh_token: "Token",
      secret_code: "secret"
    } |> Map.drop([key_to_drop])

    changeset =
      %RefreshToken{user_id: user_id}
      |> RefreshToken.changeset(parameters)

    refute changeset.valid?
  end

  test "[INVALID][CHANGESET] Duplicated code" do
    user = insert(:user)
    token = insert(:refresh_token, %{user_id: user.id})

    parameters = %{
      refresh_token: token.refresh_token,
      secret_code: token.secret_code
    }

    changeset =
      %RefreshToken{user_id: user.id}
      |> RefreshToken.changeset(parameters)

    result = PlantMonitor.Repo.insert(changeset)
    assert match?({:error, %Ecto.Changeset{}}, result)
  end

end
