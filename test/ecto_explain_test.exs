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
    query = from(posts in Post)
    assert Repo.explain(query) == query
  end

  test "explain update_all" do
    post = Repo.insert!(%Post{title: "original title"})
    query = from(posts in Post, update: [set: [title: ^"hello"]])
    assert Repo.explain(query, op: :update_all) == query
    assert %Post{title: "original title"} = Repo.get!(Post, post.id)
  end

  test "explain format text " do
    query = from(posts in Post)
    assert Repo.explain(query, format: :json) == query
  end

  test "explain format json" do
    query = from(posts in Post)
    assert Repo.explain(query, format: :json) == query
  end

  test "explain format yaml" do
    query = from(posts in Post)
    assert Repo.explain(query, format: :yaml) == query
  end

  test "log output false" do
    query = from(posts in Post)
    refute Repo.explain(query, log_output: false) == query
    assert %Postgrex.Result{
      rows: [[[%{"Plan" => %{}}]]]
    } = Repo.explain(query, log_output: false)
  end

  test "explain analyze" do
    query = from(posts in Post)

    assert %Postgrex.Result{
      rows: [[[%{
        "Execution Time" => execution_time,
        "Planning Time" => planning_time,
        "Triggers" => [],
        "Plan" => %{
          "Actual Loops" => actual_loops,
          "Actual Rows" => actual_rows,
          "Actual Startup Time" => actual_startup_time,
          "Actual Total Time" => actual_total_time,
        }
      }]]]
    } =  Repo.explain(query, analyze: true, log_output: false)

    assert is_float(execution_time)
    assert is_float(planning_time)
    assert is_float(actual_startup_time)
    assert is_float(actual_total_time)
    assert is_integer(actual_loops)
    assert is_integer(actual_rows)
  end
end
