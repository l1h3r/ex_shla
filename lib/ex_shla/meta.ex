defmodule ExShla.Meta do
  @moduledoc """
  ExShla Meta
  """
  @attrs [
    count: 0,
    pages: 0,
    next: "",
    prev: ""
  ]

  @enforce_keys Keyword.keys(@attrs)

  defstruct @attrs

  @type t :: %__MODULE__{
          count: integer,
          pages: integer,
          next: binary,
          prev: binary
        }
end
