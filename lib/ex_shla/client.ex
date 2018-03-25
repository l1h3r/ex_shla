defmodule ExShla.Client do
  @moduledoc """
  ExShla Client
  """
  use HTTPoison.Base

  alias HTTPoison.{
    Response,
    Error
  }

  @type response :: Response.t() | Error.t()
  @type parsed :: {:ok, binary} | {:error, atom | binary}

  @headers [{~s(Content-Type), ~s(application/json; charset=utf-8)}]

  @options [recv_timeout: 15_000]

  @endpoint ~s(https://rickandmortyapi.com/api)

  @doc """
  Parses the HTTPoison response.
  """
  @spec parse(response :: response) :: parsed
  def parse(%Response{body: %{error: reason}}), do: {:error, reason}
  def parse(%Response{status_code: 429}), do: {:error, :too_many_requests}
  def parse(%Response{status_code: 200, body: body}), do: {:ok, body}
  def parse(%Error{reason: reason}), do: {:error, reason}

  @doc """
  Processes the response body before returning to the caller.

  ## Examples

      iex> process_response_body(~s({"key":"value"}))
      %{key: "value"}

      iex> process_response_body("not json")
      "not json"

  """
  @spec process_response_body(body :: binary) :: binary
  def process_response_body(body) do
    Poison.decode!(body, keys: :atoms!)
  rescue
    _ in Poison.SyntaxError ->
      body
  end

  # ======= #
  # Private #
  # ======= #

  defp process_request_headers(headers), do: headers ++ @headers

  defp process_request_options(options), do: options ++ @options

  defp process_url(url), do: @endpoint <> url
end
