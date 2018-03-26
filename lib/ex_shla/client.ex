defmodule ExShla.Client do
  @moduledoc """
  Internal module for API communication
  """
  use HTTPoison.Base

  alias HTTPoison.{
    Response,
    Error
  }

  @type reason :: :too_many_requests | :redirected | :bad_json | binary
  @type parsed :: {:ok, map} | {:error, reason}

  @headers [{~s(Content-Type), ~s(application/json; charset=utf-8)}]

  @options [recv_timeout: 15_000]

  @endpoint ~s(https://rickandmortyapi.com/api)

  @doc """
  Parses the HTTPoison response.
  """
  @spec parse(response :: Response.t() | Error.t()) :: parsed
  def parse(%Response{body: %{error: reason}}), do: {:error, reason}
  def parse(%Response{status_code: 429}), do: {:error, :too_many_requests}
  def parse(%Response{status_code: 301}), do: {:error, :redirected}
  def parse(%Response{status_code: 200, body: body}), do: {:ok, body}
  def parse(%Error{reason: reason}), do: {:error, reason}

  @doc """
  Processes the response body before returning to the caller.

  ## Examples

      iex> process_response_body(~s({"key":"value"}))
      %{key: "value"}

      iex> process_response_body("not json")
      %{error: :bad_json, data: "not json"}

  """
  @spec process_response_body(body :: binary) :: map
  def process_response_body(body) do
    case Poison.decode(body, keys: :atoms!) do
      {:ok, data} ->
        data
      _ ->
        %{error: :bad_json, data: body}
    end
  end

  # ======= #
  # Private #
  # ======= #

  defp process_request_headers(headers), do: headers ++ @headers

  defp process_request_options(options), do: options ++ @options

  defp process_url(url), do: @endpoint <> url
end
