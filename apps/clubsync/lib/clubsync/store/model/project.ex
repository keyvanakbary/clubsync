defmodule Clubsync.Store.Model.Project do
  use Ecto.Schema

  alias Clubhousex.Project
  alias Clubsync.Store.Model.DateTime

  schema "projects" do
    field(:name, :string)
    field(:archived, :boolean)
    field(:start_time, :utc_datetime)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
  end

  def from_clubhouse(%Project{} = project) do
    %__MODULE__{
      id: project.id,
      name: project.name,
      archived: project.archived,
      start_time: DateTime.normalize(project.start_time),
      created_at: DateTime.normalize(project.created_at),
      updated_at: DateTime.normalize(project.updated_at)
    }
  end
end
