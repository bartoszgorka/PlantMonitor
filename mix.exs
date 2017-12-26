defmodule PlantMonitor.Mixfile do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      dialyzer: dialyzer(),
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test
      ],
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:excoveralls, "~> 0.7", only: [:dev, :test], runtime: false},
    ]
  end

  defp aliases do
    [
      "credo": ["credo --strict"],
      "coveralls": ["coveralls --umbrella"],
      "coveralls.detail": ["coveralls.detail --umbrella"],
    ]
  end

  defp dialyzer do
    [
      flags: [:error_handling, :race_conditions, :underspecs, :unmatched_returns],
      plt_add_apps: [:ex_unit, :mix],
    ]
  end

end
