defmodule Explain.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_explain,
      version: "0.1.2",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),

      # Docs
      name: "Ecto Explain",
      source_url: "https://github.com/revelrylabs/ecto_explain",
      homepage_url: "https://github.com/revelrylabs/ecto_explain",
      docs: [extras: ["README.md"]]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ecto, "~> 2.1", only: [:test]},
      {:postgrex, ">= 0.0.0", only: [:test]},
      {:jason, "~> 1.1", only: [:test]},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test]}
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
