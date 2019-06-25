defmodule Ecto.Explain do
  @moduledoc """
  Explain functions for `Ecto.Repo`.
  """

  @doc false
  defmacro __using__(_) do
    quote location: :keep do
      def explain(query, opts \\ []) do
        opts = put_defaults(opts)

        {sql, params} = Ecto.Adapters.SQL.to_sql(opts[:op], __MODULE__, query)

        sql =
          "EXPLAIN (#{analyze_to_sql(opts[:analyze])}, #{format_to_sql(opts[:format])}) #{sql}"

        {:error, explain} =
          __MODULE__.transaction(fn ->
            __MODULE__
            |> Ecto.Adapters.SQL.query!(sql, params)
            |> __MODULE__.rollback()
          end)

        if opts[:log_output] do
          log_output(explain, opts[:format])
          query
        else
          explain
        end
      end

      defp put_defaults(opts) do
        opts
        |> Keyword.put_new(:op, :all)
        |> Keyword.put_new(:format, :json)
        |> Keyword.put_new(:analyze, false)
        |> Keyword.put_new(:log_output, true)
      end

      defp log_output(results, :text) do
        results
        |> Map.get(:rows)
        |> Enum.join("\n")
        |> IO.puts()
      end

      defp log_output(results, :json) do
        results
        |> Map.get(:rows)
        |> List.first()
        |> Jason.encode!(pretty: true)
        |> IO.puts()
      end

      defp log_output(results, :yaml) do
        results
        |> Map.get(:rows)
        |> List.first()
        |> IO.puts()
      end

      defp format_to_sql(:text), do: "FORMAT TEXT"
      defp format_to_sql(:json), do: "FORMAT JSON"
      defp format_to_sql(:yaml), do: "FORMAT YAML"

      defp analyze_to_sql(true), do: "ANALYZE true"
      defp analyze_to_sql(false), do: "ANALYZE false"
    end
  end

  @doc """
  Fetches the execution plan of a given query. More information on postgres
  explain [here](https://www.postgresql.org/docs/current/sql-explain.html).

  ## Options
      * `log_output` - Defaults to true. You can optionally set this option to
      false. When false the explain function will return the execution plan of
      the given query.

      * `analyze` - Defaults to false. Carry out the command and show actual run
      times and other statistics.

      * `format` - Specify the output format, which can be `:text`, `:json`, or
      `:yaml`. Defaults to `:json`.

      * `op` - The first argument passed to `Ecto.Adapters.SQL.to_sql`.
      Defaults to `:all`. Other options are `:update_all` or `:delete_all`.

  ## Example


      query = select(Post, [p], p.title)

      # By default explain logs the execution plan and returns the given query.

      ```
      MyRepo.explain(query) == query
      ```

      # Because explain returns the given query it can be used inside a pipeline.

      ```
      query
      |> MyRepo.explain()
      |> MyRepo.all()
      ```

      # It can also be set to return the execution plan instead for programmatic analysis.

      ```
      %Postgrex.Result{rows: [[[%{"Plan" => %{}}]]]} = MyRepo.explain(query, log_output: false)
      ```
  """
  @callback explain(queryable :: Ecto.Queryable.t(), opts :: Keyword.t()) :: Ecto.Queryable.t() | []
end
