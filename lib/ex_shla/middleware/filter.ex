defmodule ExShla.Middleware.Filter do
  @moduledoc """
  Filter middleware for Tesla
  """
  @behaviour Tesla.Middleware

  # Globally available query params
  @global ~w(page)a

  def call(%Tesla.Env{} = env, next, opts \\ []) do
    env
    |> Map.update!(:query, &Keyword.take(&1, opts ++ @global))
    |> Tesla.run(next)
  end
end
