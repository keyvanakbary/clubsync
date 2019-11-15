defmodule Clubsync.Store.Model.Label do
  use Ecto.Schema

  alias Clubhousex.Label
  alias Clubsync.Store.Model.DateTime

  schema "labels" do
    field(:name, :string)
    field(:archived, :boolean)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
  end

  def from_clubhouse(%Label{} = label) do
    %__MODULE__{
      id: label.id,
      name: label.name,
      archived: label.archived,
      created_at: DateTime.normalize(label.created_at),
      updated_at: DateTime.normalize(label.updated_at)
    }
  end
end
