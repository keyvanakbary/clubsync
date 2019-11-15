defmodule Clubhousex.Label do
  use TypedStruct

  alias Clubhousex.DateTime

  typedstruct do
    field(:id, integer, enforce: true)
    field(:name, String.t(), enforce: true)
    field(:archived, boolean, enforce: true)
    field(:created_at, DateTime.t(), enforce: true)
    field(:updated_at, DateTime.t(), enforce: true)
  end

  @spec from_map(map()) :: __MODULE__.t()
  def from_map(map) when is_map(map) do
    %__MODULE__{
      id: map["id"],
      name: map["name"],
      archived: map["archived"],
      created_at: DateTime.from_iso8601(map["created_at"]),
      updated_at: DateTime.from_iso8601(map["updated_at"])
    }
  end
end
