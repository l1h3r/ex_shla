defmodule ExShla do
  @moduledoc """
  ExShla - The Rick and Morty API Wrapper

  ## Characters

      # Single character by ID
      iex> ExShla.character(1)

      # Multiple characters by name
      iex> ExShla.characters(name: "morty")

      # Multiple characters by status
      iex> ExShla.characters(status: "alive")

      # Multiple characters by species
      iex> ExShla.characters(species: "human")

      # Multiple characters by type
      iex> ExShla.characters(type: "cyborg")

      # Multiple characters by gender
      iex> ExShla.characters(gender: "unknown")

      # Combine character filters
      iex> ExShla.characters(name: "rick", status: "dead")

  ## Episodes

      # Single episode by ID
      iex> ExShla.episode(1)

      # Multiple episodes by name
      iex> ExShla.episodes(name: "morty")

      # Multiple episodes by episode code
      iex> ExShla.episodes(episode: "s02")

      # Combine episode filters
      iex> ExShla.episodes(name: "rick", episode: "s01")

  ## Locations

      # Single location by ID
      iex> ExShla.location(1)

      # Multiple locations by name
      iex> ExShla.locations(name: "earth")

      # Multiple locations by type
      iex> ExShla.locations(type: "planet")

      # Combine location filters
      iex> ExShla.locations(type: "planet", dimension: "c-137")

  """
  alias ExShla.{
    Client,
    Resource.Character,
    Resource.Episode,
    Resource.Location
  }

  @doc """
  Fetches a character by ID.
  """
  @spec character(id :: integer) :: Character.member()
  defdelegate character(id), to: Character, as: :one

  @doc """
  Fetches a list of characters.

  Optionally filtered by `name/status/species/type/gender`.
  """
  @spec characters(opts :: keyword) :: Character.collection()
  defdelegate characters(opts \\ []), to: Character, as: :all

  @doc """
  Fetches an episode by ID.
  """
  @spec episode(id :: integer) :: Episode.member()
  defdelegate episode(id), to: Episode, as: :one

  @doc """
  Fetches a list of episodes.

  Optionally filtered by `name/episode`.
  """
  @spec episodes(opts :: keyword) :: Episode.collection()
  defdelegate episodes(opts \\ []), to: Episode, as: :all

  @doc """
  Fetches a location by ID.
  """
  @spec location(id :: integer) :: Episode.member()
  defdelegate location(id), to: Location, as: :one

  @doc """
  Fetches a list of locations.

  Optionally filtered by `name/type/dimension`.
  """
  @spec locations(opts :: keyword) :: Location.collection()
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
