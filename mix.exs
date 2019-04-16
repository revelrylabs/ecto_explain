defmodule Explain.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_explain,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0", only: [:test]},
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false},
      {:jason, "~> 1.1"},
    ]
  end

  defp description do
    """
    Explain with Ecto.
    """
  end
end
