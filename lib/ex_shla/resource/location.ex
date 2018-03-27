defmodule ExShla.Resource.Location do
  @moduledoc """
  Rick and Morty location data from an API response

  ## Attributes

    `id` The id of the location.

    `name` The name of the location.

    `type` The type of the location.

    `dimension` The dimension in which the location is located.

    `residents` List of character who have been last seen in the location.

    `url` Link to the location's own endpoint.

    `created` Time at which the location was created in the database.

  """
  @enforce_keys ~w(id name type dimension residents url created)a

  defstruct @enforce_keys

  use ExShla.Client,
    name: :location,
    filter: ~w(name type dimension)a

  @type t :: %__MODULE__{
          id: integer,
          name: binary,
          type: binary,
          dimension: binary,
          residents: [binary],
          url: binary,
          created: binary
        }
end
