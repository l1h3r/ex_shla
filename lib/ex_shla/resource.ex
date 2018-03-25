defmodule ExShla.Resource do
  @moduledoc """
  ExShla Resource
  """
  @type result :: {:ok, map} | {:error, atom | binary}

  @callback all(opts :: keyword) :: result

  @callback one(id :: binary) :: result

  defmacro __using__(opts) do
    quote do
      alias ExShla.{
        Client,
        Meta,
        Resource
      }

      @type expanded :: %{meta: Meta.t(), data: [t]}

      @name Keyword.fetch!(unquote(opts), :name)

      @attrs Keyword.fetch!(unquote(opts), :attrs)

      @filters [:page | Keyword.get(unquote(opts), :filters, [])]

      @enforce_keys Keyword.keys(@attrs)

      defstruct @attrs

      @behaviour Resource

      @impl true
      def all(opts \\ []) do
        with {:ok, response} <- Client.get("/#{@name}/?#{to_query(opts)}"),
             {:ok, body} <- Client.parse(response) do
          {:ok, expand(body)}
        end
      end

      @impl true
      def one(id) do
        with {:ok, response} <- Client.get("/#{@name}/#{id}/"),
             {:ok, body} <- Client.parse(response) do
          {:ok, to_struct(body)}
        end
      end

      @spec expand(body :: map) :: expanded
      defp expand(%{results: results, info: info}) do
        %{
          meta: struct!(Meta, info),
          data: Enum.map(results, &to_struct/1)
        }
      end

      @spec to_struct(attrs :: map) :: t
      defp to_struct(attrs), do: struct!(__MODULE__, attrs)

      @spec to_query(opts :: keyword) :: binary
      defp to_query(opts), do: opts |> Keyword.take(@filters) |> URI.encode_query()
    end
  end
end
