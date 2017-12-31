defmodule PlantMonitor.UserFactory do
  @moduledoc """
  `PlantMonitor.User` schema factory.
  """

  defmacro __using__(_opts) do
    quote do

      def user_factory do
        %PlantMonitor.User{
          email: sequence(:email, &"john.example#{&1}@example.com"),
          password: sequence("Password")
        } |> PlantMonitor.UserFactory.encrypt_password()
      end
    end
  end

  @doc """
  Encrypt password stored in `PlantMonitor.User`, field :password.
  Set this change as `encrypted_password` field.
  """
  def encrypt_password(%{password: password} = user) do
    encrypted =
      password
      |> Comeonin.Bcrypt.hashpwsalt()

    Map.merge(user, %{encrypted_password: encrypted})
  end

end
