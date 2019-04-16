defmodule Ecto.Explain.Test.Repo do
  use Ecto.Repo, otp_app: :ecto_explain, adapter: Ecto.Adapters.Postgres
  use Ecto.Explain.Repo
end
