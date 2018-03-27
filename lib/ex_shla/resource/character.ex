defmodule ExShla.Resource.Character do
  @moduledoc """
  Rick and Morty character data from an API response

  ## Attributes

    `id` The id of the character.

    `name` The name of the character.

    `status` The status of the character: `Alive, Dead, unknown`.

    `species` The species of the character.

    `type` The type or subspecies of the character.

    `gender` The gender of the character: `Female, Male, Genderless, unknown`.

    `origin` Name and link to the character's origin location.

    `location` Name and link to the character's last known location endpoint.

    `image` Link to the character's image.

    `episode` List of episodes in which this character appeared.

    `url` Link to the character's own URL endpoint.

    `created` Time at which the character was created in the database.

  """
  @enforce_keys ~w(id name status species type gender origin location image episode url created)a

  defstruct @enforce_keys

  use ExShla.Client,
    name: :character,
    filter: ~w(name status species type gender)a

  @type t :: %__MODULE__{
          id: integer,
          name: binary,
          status: binary,
          species: binary,
          type: binary,
          gender: binary,
          origin: map,
          location: map,
          image: binary,
          episode: [binary],
          url: binary,
          created: binary
        }
end
