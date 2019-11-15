defmodule Clubhousex.Project do
  use TypedStruct

  alias Clubhousex.DateTime

  typedstruct do
    field(:id, integer, enforce: true)
    field(:team_id, integer, enforce: true)
    field(:name, String.t(), enforce: true)
    field(:archived, boolean, enforce: true)
    field(:start_time, DateTime.t(), enforce: true)
    field(:created_at, DateTime.t(), enforce: true)
    field(:updated_at, DateTime.t(), enforce: true)
  end

  @spec from_map(map()) :: __MODULE__.t()
  def from_map(map) when is_map(map) do
    %__MODULE__{
      id: map["id"],
      team_id: map["team_id"],
      name: map["name"],
      archived: map["archived"],
      start_time: DateTime.from_iso8601(map["start_time"]),
      created_at: DateTime.from_iso8601(map["created_at"]),
      updated_at: DateTime.from_iso8601(map["updated_at"])
    }
  end
end
