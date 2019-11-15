defmodule Clubsync.Store.Repo do
  use Ecto.Repo,
    otp_app: :clubsync,
    adapter: Ecto.Adapters.MyXQL

  import Ecto.Query, only: [from: 2]

  alias Clubhousex.{Story, Label, Project}
  alias Clubsync.Store.Model

  @type num_results :: integer

  @spec add_labels([Label.t()]) :: num_results
  def add_labels(labels) do
    labels
    |> Enum.map(&Model.Label.from_clubhouse/1)
    |> bulk_insert(Model.Label)
  end

  @spec add_projects([Project.t()]) :: num_results
  def add_projects(projects) do
    projects
    |> Enum.map(&Model.Project.from_clubhouse/1)
    |> bulk_insert(Model.Project)
  end

  @spec add_stories([Story.t()]) :: num_results
  def add_stories(stories) do
    stories
    |> Enum.chunk_every(1000)
    |> Enum.map(&add_chunked_stories/1)
    |> Enum.sum()
  end

  defp add_chunked_stories(stories) do
    num =
      stories
      |> Enum.map(&Model.Story.from_clubhouse/1)
      |> bulk_insert(Model.Story)

    stories
    |> Enum.map(&Model.StoryLabel.from_clubhouse/1)
    |> List.flatten()
    |> bulk_insert(Model.StoryLabel)

    num
  end

  def last_story_created_at(),
    do: query_latest_field(Model.Story, :created_at)

  defp query_latest_field(schema, field) do
    schema
    |> from(select: ^[field], order_by: ^[desc: field], limit: 1)
    |> one()
    |> extract_field(field)
  end

  defp extract_field(nil, _field), do: nil
  defp extract_field(result, field), do: Map.get(result, field)

  defp bulk_insert(entities, model) do
    entries = entities |> Enum.map(&to_map/1)
    {num, _} = insert_all(model, entries, on_conflict: :replace_all)
    num
  end

  defp to_map(entity) do
    Map.drop(entity, [:__struct__, :__meta__])
  end
end
