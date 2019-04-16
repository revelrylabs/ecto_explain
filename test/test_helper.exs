{:ok, _} = Application.ensure_all_started(:postgrex)
{:ok, _pid} = Ecto.Explain.Test.Repo.start_link

defmodule Ecto.Explain.Test.Migrations do
  use Ecto.Migration

  def change do
    drop_if_exists table(:posts)
    create table(:posts) do
      add :title, :string
      add :body, :string
    end
  end
end

_ = Ecto.Migrator.up(Ecto.Explain.Test.Repo, 0, Ecto.Explain.Test.Migrations, log: false)
ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Ecto.Explain.Test.Repo, :manual)
