defmodule PlantMonitor.MutationAdapter do
  @moduledoc """
  Mutation adapter - when object change parameters, return `:ok` or `{:error, reason}`.
  """

  @doc """
  Prevent get mutation as result

  ## Parameters
      tuple

  ## Returns
      :ok
      {:error, Ecto.Changeset}
      {:error, atom}
  """
  def prevent({:ok, _struct}), do: :ok
  def prevent({:error, _field, %Ecto.Changeset{} = changeset, _changes}), do: {:error, changeset}
  def prevent({:error, %Ecto.Changeset{}} = error), do: error
  def prevent({:error, atom}) when is_atom(atom), do: {:error, atom}

end
