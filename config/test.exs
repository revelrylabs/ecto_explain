use Mix.Config

config :ecto_explain, ecto_repos: [Ecto.ExplainTest.Repo]

config :ecto_explain, Ecto.ExplainTest.Repo,
  database: "ecto_explain_test",
  hostname: "localhost",
  port: 5432,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  types: EctoExplain.PostgresTypes
