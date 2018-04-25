# ExShla - The Rick and Morty API Wrapper

[![Build Status](https://travis-ci.org/l1h3r/ex_shla.svg?branch=master)](https://travis-ci.org/l1h3r/ex_shla)
[![Coverage Status](https://coveralls.io/repos/github/l1h3r/ex_shla/badge.svg?branch=master)](https://coveralls.io/github/l1h3r/ex_shla?branch=master)
[![Hex.pm](https://img.shields.io/hexpm/v/ex_shla.svg?style=flat-square)](https://hex.pm/packages/ex_shla)
[![Hex.pm](https://img.shields.io/hexpm/dt/ex_shla.svg?style=flat-square)](https://hex.pm/packages/ex_shla)

> Hey, did you ever want to hold a terry fold?,
>  I got one right here, grab my terry flap.

**Elixir client for the Rick and Morty API**

[The Rick and Morty API](https://rickandmortyapi.com) (or ShlaAPI) is a RESTful API based on the television show [Rick and Morty](https://www.adultswim.com/videos/rick-and-morty). You will access to data about hundreds of characters, images, locations and episodes.

**To get started check the documentation on [rickandmortyapi.com](https://rickandmortyapi.com/documentation)**

## Installation

Add `ex_shla` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_shla, "~> 0.1.5"}
  ]
end
```

## Usage

### Get API Info

```elixir
iex> ExShla.info()
%{
  characters: "https://rickandmortyapi.com/api/character",
  episodes: "https://rickandmortyapi.com/api/episode",
  locations: "https://rickandmortyapi.com/api/location"
}
```

### Get a character by id

```elixir
iex> ExShla.character(1)
{:ok, %ExShla.Resource.Character{
  created: "2017-11-04T18:48:46.250Z",
  episode: [
    "https://rickandmortyapi.com/api/episode/1",
    ...
  ],
  gender: "Male",
  id: 1,
  image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
  location: %{
    name: "Earth (Replacement Dimension)",
    url: "https://rickandmortyapi.com/api/location/20"
  },
  name: "Rick Sanchez",
  origin: %{
    name: "Earth (C-137)",
    url: "https://rickandmortyapi.com/api/location/1"
  },
  species: "Human",
  status: "Alive",
  type: "",
  url: "https://rickandmortyapi.com/api/character/1"
}}
```

### Get all characters (paginated)

```elixir
iex> ExShla.characters()
{:ok, %{
  data: [%ExShla.Resource.Character{}, ...],
  meta: %ExShla.Meta{
    count: 394,
    next: "https://rickandmortyapi.com/api/character/?page=2",
    pages: 20,
    prev: ""
  }
}}
```

### Get an episode by id

```elixir
iex> ExShla.episode(1)
{:ok, %ExShla.Resource.Episode{
  air_date: "December 2, 2013",
  characters: [
    "https://rickandmortyapi.com/api/character/1",
    ...
  ]
  created: "2017-11-10T12:56:33.798Z",
  episode: "S01E01",
  id: 1,
  name: "Pilot",
  url: "https://rickandmortyapi.com/api/episode/1"
}}
```

### Get all episodes (paginated)

```elixir
iex> ExShla.episodes()
{:ok, %{
  data: [%ExShla.Resource.Episode{}, ...],
  meta: %ExShla.Meta{
    count: 31,
    next: "https://rickandmortyapi.com/api/episode/?page=2",
    pages: 2,
    prev: ""
  }
}}
```

### Get a location by id

```elixir
iex> ExShla.location(1)
{:ok, %ExShla.Resource.Location{
  created: "2017-11-10T12:42:04.162Z",
  dimension: "Dimension C-137",
  id: 1,
  name: "Earth (C-137)",
  residents: [
    "https://rickandmortyapi.com/api/character/38",
    ...
  ],
  type: "Planet",
  url: "https://rickandmortyapi.com/api/location/1"
}}
```

### Get all locations (paginated)

```elixir
iex> ExShla.locations()
{:ok, %{
  data: [%ExShla.Resource.Location{}, ...],
  meta: %ExShla.Meta{
    count: 67,
    next: "https://rickandmortyapi.com/api/location/?page=2",
    pages: 4,
    prev: ""
  }
}}
```
