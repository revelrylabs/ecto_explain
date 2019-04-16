use Mix.Config

config :ecto_explain, ecto_repos: [Ecto.Explain.Test.Repo]

config :ecto_explain, Ecto.Explain.Test.Repo,
  database: "ecto_explain_test",
  hostname: "localhost",
  port: 5432,
  pool: Ecto.Adapters.SQL.Sandbox,
  types: EctoExplain.PostgresTypes
