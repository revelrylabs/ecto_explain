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

# posts.ex
Repo.explain(from(p in Post))
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ecto_explain` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_explain, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ecto_explain](https://hexdocs.pm/ecto_explain).

