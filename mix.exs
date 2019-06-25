defmodule Explain.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_explain,
      version: "0.1.3",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      deps: deps(),
      description: description(),
      package: package(),
      # Docs
      name: "Ecto Explain",
      source_url: "https://github.com/revelrylabs/ecto_explain",
      homepage_url: "https://github.com/revelrylabs/ecto_explain",
      docs: [main: "readme", extras: ["README.md"]]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:credo, ">= 0.5.1", only: [:dev, :test]},
      {:ecto, "~> 2.2.0", only: [:test]},
      {:excoveralls, "~> 0.8", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test]},
      {:postgrex, "~> 0.13", only: [:test]},
      {:jason, "~> 1.1", only: [:dev, :test]}
    ]
  end

  defp description do
    """
    Explain with Ecto.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE", "CHANGELOG.md"],
      maintainers: ["Revelry Labs"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/revelrylabs/ecto_explain"
      },
      build_tools: ["mix"]
    ]
  end
end
