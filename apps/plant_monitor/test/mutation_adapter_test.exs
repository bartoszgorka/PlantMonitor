defmodule PlantMonitor.MutationAdapterTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.MutationAdapter

  # PREVENT

  test "[PREVENT] Correct mutation" do
    check = {:ok, %PlantMonitor.User{}}
    result = MutationAdapter.prevent(check)

    assert :ok == result
  end

  test "[PREVENT] Error with Ecto.Changeset result" do
    check = {:error, %Ecto.Changeset{}}
    result = MutationAdapter.prevent(check)

    assert check == result
  end

  test "[PREVENT] Error with atom" do
    check = {:error, :no_found}
    result = MutationAdapter.prevent(check)

    assert check == result
  end

end
