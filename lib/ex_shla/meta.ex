defmodule ExShla.Meta do
  @moduledoc """
  Metadata from an API response

  ## Attributes

    `count` The length of the response

    `pages` The amount of pages

    `next` Link to the next page (*if it exists*)

    `prev` Link to the previous page (*if it exists*)

  """
  @enforce_keys [
    :count,
    :pages,
    :next,
    :prev
  ]

  defstruct @enforce_keys

  @type t :: %__MODULE__{
          count: integer,
          pages: integer,
          next: binary,
          prev: binary
        }
end
