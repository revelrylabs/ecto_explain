{:ok, _} = Application.ensure_all_started(:postgrex)
{:ok, _pid} = Ecto.ExplainTest.Repo.start_link()

defmodule Ecto.ExplainTest.Migrations do
  use Ecto.Migration

  def change do
    drop_if_exists(table(:posts))

    create table(:posts) do
      add(:title, :string)
      add(:body, :string)
    end
  end
end

_ = Ecto.Migrator.up(Ecto.ExplainTest.Repo, 0, Ecto.ExplainTest.Migrations, log: false)
ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Ecto.ExplainTest.Repo, :manual)
