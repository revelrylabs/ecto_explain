# Explain

Adds explain function to Ecto.Repo

## Usage

To include the explain function in repos, just add use Ecto.Explain to your repo. After that, the function explain/1 will be available for you.

```elixir
# repo.ex
defmodule Ecto.ExplainTest.Repo do
  use Ecto.Repo, 
    otp_app: :my_project, 
    adapter: Ecto.Adapters.Postgres
  use Ecto.Explain
end
```

```elixir
# posts.ex
Repo.explain(from(p in Post))

Update on posts p0  (cost=0.00..10.70 rows=70 width=1046)
  ->  Seq Scan on posts p0  (cost=0.00..10.70 rows=70 width=1046)
```

```elixir
Repo.explain(from(posts in Post), format: :json, analyze: true)

[
  [
    {
      "Execution Time": 0.084,
      "Plan": {
        "Actual Loops": 1,
        "Actual Rows": 0,
        "Actual Startup Time": 0.027,
        "Actual Total Time": 0.027,
        "Alias": "p0",
        "Node Type": "Seq Scan",
        "Parallel Aware": false,
        "Plan Rows": 70,
        "Plan Width": 1040,
        "Relation Name": "posts",
        "Startup Cost": 0.0,
        "Total Cost": 10.7
      },
      "Planning Time": 0.585,
      "Triggers": []
    }
  ]
]
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ecto_explain` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_explain, "~> 0.1.2"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ecto_explain](https://hexdocs.pm/ecto_explain).

