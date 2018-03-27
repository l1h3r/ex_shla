defmodule ExShla.Client do
  @moduledoc """
  Internal module for API communication
  """
  defmacro __using__(opts) do
    quote do
      require ExShla.Client
      import ExShla.Client

      use Tesla,
        only: ~w(get)a,
        docs: false

      alias ExShla.Meta

      @name unquote(opts) |> Keyword.fetch!(:name) |> to_string()

      @filter unquote(opts) |> Keyword.get(:filter, [])

      plug(ExShla.Middleware.Error)

      plug(Tesla.Middleware.Tuples)
      plug(Tesla.Middleware.BaseUrl, ~s(https://rickandmortyapi.com/api/))
      plug(Tesla.Middleware.FollowRedirects, max_redirects: 1)
      plug(Tesla.Middleware.Timeout, timeout: 15_000)
      plug(Tesla.Middleware.DecodeJson, engine_opts: [keys: :atoms!])

      if Mix.env() == :dev, do: plug(Tesla.Middleware.Logger)

      plug(ExShla.Middleware.Filter, @filter)

      @type data :: %{meta: Meta.t(), data: [t]}
      @type reason :: atom | binary
      @type error :: {:error, reason}
      @type success :: {:ok, struct} | {:ok, data}
      @type result :: success | error

      @spec one(id :: integer) :: result
      def one(id) do
        with {:ok, %Tesla.Env{body: body}} <- get("#{@name}/#{id}/") do
          {:ok, struct!(__MODULE__, body)}
        end
      end

      @spec all(query :: keyword) :: result
      def all(query \\ []) do
        with {:ok, %Tesla.Env{body: body}} <- get("#{@name}/", query: query) do
          {:ok, expand_data(body)}
        end
      end

      @doc false
      @spec __info__ :: map
      def __info__, do: get("/")

      @spec expand_data(body :: map) :: data
      defp expand_data(%{results: results, info: info}) do
        %{
          meta: struct!(Meta, info),
          data: Enum.map(results, &struct!(__MODULE__, &1))
        }
      end
    end
  end
end
