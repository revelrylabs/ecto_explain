defmodule Ecto.ExplainTest do
  use ExUnit.Case
  alias Ecto.ExplainTest.Repo
  import Ecto.Query, warn: false

  defmodule Post do
    use Ecto.Schema

    schema "posts" do
      field(:title, :string)
      field(:body, :string)
    end
  end

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Ecto.ExplainTest.Repo)
  end

  test "explain all" do
    assert %Ecto.Query{} = Repo.explain(from(posts in Post))
  end

  test "explain update_all" do
    post = Repo.insert!(%Post{title: "original title"})
    assert %Ecto.Query{} = from(posts in Post, update: [set: [title: ^"hello"]]) |> Repo.explain(op: :update_all)
    assert %Post{title: "original title"} = Repo.get!(Post, post.id)
  end

  test "explain and analyze format text " do
    assert %Ecto.Query{} = Repo.explain(from(posts in Post), format: :json, analyze: true)
  end

  test "explain and analyze format json" do
    assert %Ecto.Query{} = Repo.explain(from(posts in Post), format: :json, analyze: true)
  end

  test "explain and analyze format yaml" do
    assert %Ecto.Query{} = Repo.explain(from(posts in Post), format: :yaml, analyze: true)
  end
end
