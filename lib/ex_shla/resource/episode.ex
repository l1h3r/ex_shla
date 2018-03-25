defmodule ExShla.Resource.Episode do
  @moduledoc """
  ExShla Resource Episode
  """
  use ExShla.Resource,
    name: :episode,
    filters: ~w(name episode)a,
    attrs: [
      id: nil,
      name: "",
      air_date: "",
      episode: "",
      characters: [],
      url: "",
      created: ""
    ]

  @type t :: %__MODULE__{
          id: integer | nil,
          name: binary,
          air_date: binary,
          episode: binary,
          characters: [binary],
          url: binary,
          created: binary
        }
end
