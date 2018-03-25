defmodule ExShla.Resource.Character do
  @moduledoc """
  ExShla Resource.Character
  """
  use ExShla.Resource,
    name: :character,
    filters: ~w(name status species type gender)a,
    attrs: [
      id: nil,
      name: "",
      status: "",
      species: "",
      type: "",
      gender: "",
      origin: %{
        name: "",
        url: ""
      },
      location: %{
        name: "",
        url: ""
      },
      image: "",
      episode: [],
      url: "",
      created: ""
    ]

  @type t :: %__MODULE__{
          id: integer | nil,
          name: binary,
          status: binary,
          species: binary,
          type: binary,
          gender: binary,
          origin: %{
            name: binary,
            url: binary
          },
          location: %{
            name: binary,
            url: binary
          },
          image: binary,
          episode: [binary],
          url: binary,
          created: binary
        }
end
