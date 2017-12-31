defmodule PlantMonitorWeb.Mixfile do
  @moduledoc false
  use Mix.Project

  # Project settings
  def project do
    [
      app: :plant_monitor_web,
      version: version(),
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
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

  # Configuration for the OTP application.
  def application do
    [
      mod: {PlantMonitorWeb.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},

      # CORS
      {:cors_plug, "~> 1.5"},

      # Permissions check
      {:conductor, "~> 0.3.0"},

    ]
  end

  # Custom mix aliases
  defp aliases do
    [
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
    ]
  end

  # Dynamic version
  defp version do
    File.read!("../../VERSION")
  end

end
