defmodule ExShla.Resource.Episode do
  @moduledoc """
  Rick and Morty episode data from an API response

  ## Attributes

    `id` The id of the episode.

    `name` The name of the episode.

    `air_date` The air date of the episode.

    `episode` The code of the episode.

    `characters` List of characters who have been seen in the episode.

    `url` Link to the episode's own endpoint.

    `created` Time at which the episode was created in the database.

  """
  @enforce_keys ~w(id name air_date episode characters url created)a

  defstruct @enforce_keys

  use ExShla.Client,
    name: :episode,
    filter: ~w(name episode)a

  @type t :: %__MODULE__{
          id: integer,
          name: binary,
          air_date: binary,
          episode: binary,
          characters: [binary],
          url: binary,
          created: binary
        }
end
