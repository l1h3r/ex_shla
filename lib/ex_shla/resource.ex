defmodule ExShla.Resource do
  @moduledoc """
  Internal macro(s) for shared resource behaviour
  """
  defmacro __using__(opts) do
    quote do
      alias ExShla.{
        Client,
        Meta,
        Resource
      }

      @type member :: {:ok, map} | {:error, atom | binary}

      @type collection :: {:ok, data} | {:error, atom | binary}

      @type data :: %{meta: Meta.t(), data: [t]}

      @name Keyword.fetch!(unquote(opts), :name)

      @enforce_keys Keyword.fetch!(unquote(opts), :keys)

      @filters [:page | Keyword.get(unquote(opts), :filters, [])]

      defstruct @enforce_keys

      @spec all(opts :: keyword) :: collection
      def all(opts \\ []) do
        with {:ok, response} <- Client.get("/#{@name}/?#{to_query(opts)}"),
             {:ok, body} <- Client.parse(response) do
          {:ok, expand(body)}
        end
      end

      @spec one(id :: binary) :: member
      def one(id) do
        with {:ok, response} <- Client.get("/#{@name}/#{id}/"),
             {:ok, body} <- Client.parse(response) do
          {:ok, to_struct(body)}
        end
      end

      @spec expand(body :: map) :: data
      defp expand(%{results: results, info: info}) do
        %{
          meta: struct!(Meta, info),
          data: to_struct(results)
        }
      end

      @spec to_struct(data :: map | [map]) :: struct
      defp to_struct(data) when is_list(data), do: Enum.map(data, &to_struct/1)
      defp to_struct(data) when is_map(data), do: struct!(__MODULE__, data)

      @spec to_query(opts :: keyword) :: binary
      defp to_query(opts), do: opts |> Keyword.take(@filters) |> URI.encode_query()
    end
  end
end
