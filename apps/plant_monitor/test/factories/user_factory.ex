defmodule PlantMonitor.UserFactory do
  @moduledoc """
  `PlantMonitor.User` schema factory.
  """

  defmacro __using__(_opts) do
    quote do

      def user_factory do
        password = sequence("Password")
        %PlantMonitor.User{
          email: sequence(:email, &"john.example#{&1}@example.com"),
          password: Comeonin.Bcrypt.hashpwsalt(password)
        }
      end
    end
  end

end
