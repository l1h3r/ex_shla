defmodule ExShla do
  @moduledoc """
  Documentation for ExShla.
  """
  alias ExShla.{
    Client,
    Resource.Character,
    Resource.Episode,
    Resource.Location
  }

  @type error :: {:error, binary | atom}

  @doc """
  Fetches a character by ID.
  """
  @spec character(id :: integer) :: {:ok, Character.t()} | error
  defdelegate character(id), to: Character, as: :one

  @doc """
  Fetches a list of characters.

  Optionally filtered by `name/status/species/type/gender`.
  """
  @spec characters(opts :: keyword) :: {:ok, Character.expanded()} | error
  defdelegate characters(opts \\ []), to: Character, as: :all

  @doc """
  Fetches an episode by ID.
  """
  @spec episode(id :: integer) :: {:ok, Episode.t()} | error
  defdelegate episode(id), to: Episode, as: :one

  @doc """
  Fetches a list of episodes.

  Optionally filtered by `name/episode`.
  """
  @spec episodes(opts :: keyword) :: {:ok, Episode.expanded()} | error
  defdelegate episodes(opts \\ []), to: Episode, as: :all

  @doc """
  Fetches a location by ID.
  """
  @spec location(id :: integer) :: {:ok, Episode.t()} | error
  defdelegate location(id), to: Location, as: :one

  @doc """
  Fetches a list of locations.

  Optionally filtered by `name/type/dimension`.
  """
  @spec locations(opts :: keyword) :: {:ok, Location.expanded()} | error
  defdelegate locations(opts \\ []), to: Location, as: :all

  @doc """
  Returns information about all available resources.
  """
  @spec info :: map
  def info do
    with {:ok, response} <- Client.get("/"),
         {:ok, body} <- Client.parse(response) do
      body
    end
  end
end
