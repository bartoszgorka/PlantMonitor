defmodule PlantMonitor.Mixfile do
  @moduledoc false
  use Mix.Project

  # Project settings
  def project do
    [
      app: :plant_monitor,
      version: version(),
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PlantMonitor.Application, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_),     do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Basic application
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 2.2.6"},

      # Encrypt password
      {:comeonin, "~> 4.0"},
      {:bcrypt_elixir, "~> 1.0"},

      # Tests
      {:ex_machina, "~> 2.1", only: :test},
      
    ]
  end

  # Custom mix aliases and shortcut
  defp aliases do
    ["test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end

  # Dynamic version
  defp version do
    File.read!("../../VERSION")
  end

end
