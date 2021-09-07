# Explain

[![Build Status](https://travis-ci.org/revelrylabs/ecto_soft_delete.svg?branch=master)](https://travis-ci.org/revelrylabs/ecto_explain)
[![Coverage Status](https://opencov.prod.revelry.net/projects/34/badge.svg)](https://opencov.prod.revelry.net/projects/34)
[![Module Version](https://img.shields.io/hexpm/v/ecto_explain.svg)](https://hex.pm/packages/ecto_explain)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ecto_explain/)
[![Total Download](https://img.shields.io/hexpm/dt/ecto_explain.svg)](https://hex.pm/packages/ecto_explain)
[![License](https://img.shields.io/hexpm/l/ecto_explain.svg)](https://github.com/revelrylabs/ecto_explain/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/revelrylabs/ecto_explain.svg)](https://github.com/revelrylabs/ecto_explain/commits/master)

Adds explain function to `Ecto.Repo`.

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

The package can be installed by adding `:ecto_explain` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_explain, "~> 0.1.2"}
  ]
end
```

## Copyright and License

Copyright (c) 2019 Revelry Labs LLC

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.
