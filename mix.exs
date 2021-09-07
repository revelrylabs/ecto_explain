defmodule Explain.MixProject do
  use Mix.Project

  @source_url "https://github.com/revelrylabs/ecto_explain"
  @version "0.1.3"

  def project do
    [
      app: :ecto_explain,
      name: "Ecto Explain",
      version: @version,
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
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ecto_sql, "~> 3.1.3", only: [:test]},
      {:postgrex, "~> 0.14.3", only: [:test]},
      {:jason, "~> 1.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.8", only: [:dev, :test]}
    ]
  end

  defp package do
    [
      description: "Explain with Ecto.",
      files: ["lib", "mix.exs", "README.md", "LICENSE.md", "CHANGELOG.md"],
      maintainers: ["Revelry Labs"],
      licenses: ["MIT"],
      build_tools: ["mix"],
      links: %{
        "Changelog" => "https://hexdocs.pm/ecto_explain/changelog.html",
        "GitHub" => @source_url
      }
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      homepage_url: @source_url,
      formatters: ["html"]
    ]
  end
end
