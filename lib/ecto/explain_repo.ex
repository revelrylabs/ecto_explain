defmodule Ecto.Explain.Repo do
  @moduledoc """
  Explain function for Ecto.Repo
  """

  defmacro __using__(_) do
    quote do
      @doc """
      Runs the EXPLAIN ANALYZE command on a query and gives the output
      """
      def explain(query, opts \\ []) do
        {op, opts} = Keyword.pop(opts, :op, :all)
        {format, _opts} = Keyword.pop(opts, :format, :text)
        {analyze, _opts} = Keyword.pop(opts, :analyze, false)

        {sql, params} = Ecto.Adapters.SQL.to_sql(op, __MODULE__, query)

        sql = "EXPLAIN (#{analyze_to_sql(analyze)}, #{format_to_sql(format)}) #{sql}"

        __MODULE__.transaction(fn ->
          __MODULE__
          |> Ecto.Adapters.SQL.query!(sql, params)
          |> format_output(format)

          __MODULE__.rollback(:explain_analyze)
        end)

        query
      end

      defp format_output(results, :text) do
        results
        |> Map.get(:rows)
        |> Enum.join("\n")
        |> format_output()
      end

      defp format_output(results, :json) do
        results
        |> Map.get(:rows)
        |> List.first()
        |> Jason.encode!(pretty: true)
        |> IO.puts()
      end

      defp format_output(results, :yaml) do
        results
        |> Map.get(:rows)
        |> List.first()
        |> format_output()
      end

      defp format_output(str), do: IO.puts(str)

      defp format_to_sql(:text), do: "FORMAT TEXT"
      defp format_to_sql(:json), do: "FORMAT JSON"
      defp format_to_sql(:yaml), do: "FORMAT YAML"

      defp analyze_to_sql(true), do: "ANALYZE true"
      defp analyze_to_sql(false), do: "ANALYZE false"
    end
  end
end
