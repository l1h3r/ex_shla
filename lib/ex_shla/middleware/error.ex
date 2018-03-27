defmodule ExShla.Middleware.Error do
  @moduledoc """
  Error handling middleware for Tesla
  """
  @behaviour Tesla.Middleware

  # Note: Must be used BEFORE Tesla.Middleware.Tuples

  def call(%Tesla.Env{} = env, next, _ \\ nil) do
    env
    |> Tesla.run(next)
    |> force_error()
  end

  @spec force_error(result :: tuple) :: tuple
  defp force_error({:ok, %{body: %{error: reason}}}), do: {:error, reason}
  defp force_error(result), do: result
end
