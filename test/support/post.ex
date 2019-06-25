defmodule Ecto.ExplainTest.Post do
  @moduledoc false
  use Ecto.Schema

  schema "posts" do
    field(:title, :string)
    field(:body, :string)
  end
end
