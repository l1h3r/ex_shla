defmodule ExShla.Resource.Location do
  @moduledoc """
  ExShla Resource Location
  """
  use ExShla.Resource,
    name: :location,
    filters: ~w(name type dimension)a,
    attrs: [
      id: nil,
      name: "",
      type: "",
      dimension: "",
      residents: [],
      url: "",
      created: ""
    ]

  @type t :: %__MODULE__{
          id: integer | nil,
          name: binary,
          type: binary,
          dimension: binary,
          residents: [binary],
          url: binary,
          created: binary
        }
end
