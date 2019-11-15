defmodule Clubsync.Store.Model.StoryLabel do
  use Ecto.Schema

  alias Clubhousex.Story

  @primary_key false
  schema "story_labels" do
    field(:story_id, :integer)
    field(:label_id, :integer)
  end

  def from_clubhouse(%Story{} = story) do
    Enum.map(story.label_ids, fn id ->
      %__MODULE__{
        story_id: story.id,
        label_id: id
      }
    end)
  end
end
