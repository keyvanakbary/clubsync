defmodule Clubhousex.Story do
  use TypedStruct

  alias Clubhousex.DateTime

  typedstruct do
    field(:id, integer, enforce: true)
    field(:project_id, integer, enforce: true)
    field(:app_url, String.t(), enforce: true)
    field(:name, String.t(), enforce: true)
    field(:story_type, String.t(), enforce: true)
    field(:archived, boolean, enforce: true)
    field(:blocker, boolean, enforce: true)
    field(:blocked, boolean, enforce: true)
    field(:started, boolean, enforce: true)
    field(:started_at, DateTime.t(), enforce: true)
    field(:completed, boolean, enforce: true)
    field(:completed_at, DateTime.t(), enforce: true)
    field(:created_at, DateTime.t(), enforce: true)
    field(:updated_at, DateTime.t(), enforce: true)
    field(:moved_at, DateTime.t(), enforce: true)
    field(:label_ids, [integer], enforce: true)
  end

  @spec from_map(map()) :: __MODULE__.t()
  def from_map(map) when is_map(map) do
    %__MODULE__{
      id: map["id"],
      name: map["name"],
      story_type: map["story_type"],
      project_id: map["project_id"],
      app_url: map["app_url"],
      started: map["started"],
      archived: map["archived"],
      blocked: map["blocked"],
      blocker: map["blocker"],
      started_at: DateTime.from_iso8601(map["started_at"]),
      completed: map["completed"],
      label_ids: map["labels"] |> Enum.map(& &1["id"]),
      completed_at: DateTime.from_iso8601(map["completed_at"]),
      moved_at: DateTime.from_iso8601(map["moved_at"]),
      created_at: DateTime.from_iso8601(map["created_at"]),
      updated_at: DateTime.from_iso8601(map["updated_at"])
    }
  end
end
