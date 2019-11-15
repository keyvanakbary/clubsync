defmodule Clubsync.Store.Model.Story do
  use Ecto.Schema

  alias Clubhousex.Story
  alias Clubsync.Store.Model.DateTime

  schema "stories" do
    field(:name, :string)
    field(:project_id, :integer)
    field(:app_url, :string)
    field(:story_type, :string)
    field(:archived, :boolean)
    field(:blocker, :boolean)
    field(:blocked, :boolean)
    field(:started, :boolean)
    field(:started_at, :utc_datetime)
    field(:completed, :boolean)
    field(:completed_at, :utc_datetime)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
    field(:moved_at, :utc_datetime)
  end

  def from_clubhouse(%Story{} = story) do
    %__MODULE__{
      id: story.id,
      name: story.name,
      project_id: story.project_id,
      app_url: story.app_url,
      story_type: story.story_type,
      archived: story.archived,
      blocker: story.blocker,
      blocked: story.blocked,
      started: story.started,
      started_at: DateTime.normalize(story.started_at),
      completed: story.completed,
      completed_at: DateTime.normalize(story.completed_at),
      created_at: DateTime.normalize(story.created_at),
      updated_at: DateTime.normalize(story.updated_at),
      moved_at: DateTime.normalize(story.moved_at)
    }
  end
end
