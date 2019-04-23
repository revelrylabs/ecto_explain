defmodule Ecto.Explain do
  @moduledoc """
  Explain function for Ecto.Repo
  """

  defmacro __using__(_) do
    quote location: :keep do
      @doc """
      Runs the EXPLAIN ANALYZE command on a query and gives the output

      Available options:

      """
      def explain(query, opts \\ []) do
        opts = put_defaults(opts)

        {sql, params} = Ecto.Adapters.SQL.to_sql(opts[:op], __MODULE__, query)

        sql = "EXPLAIN (#{analyze_to_sql(opts[:analyze])}, #{format_to_sql(opts[:format])}) #{sql}"

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
end
