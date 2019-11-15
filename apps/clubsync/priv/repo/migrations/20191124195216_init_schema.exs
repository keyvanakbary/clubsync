defmodule Migrations.InitSchema do
  use Ecto.Migration

  def change do

    create table(:labels) do
      add :name, :string, null: false
      add :archived, :boolean, null: false
      add :created_at, :utc_datetime, null: false
      add :updated_at, :utc_datetime, null: false
    end

    create table(:projects) do
      add :name, :string, null: false
      add :archived, :boolean, null: false
      add :start_time, :utc_datetime, null: false
      add :created_at, :utc_datetime, null: false
      add :updated_at, :utc_datetime, null: false
    end

    create table(:stories) do
      add :name, :text, null: false
      add :project_id, references(:projects, on_delete: :delete_all), null: false
      add :app_url, :string, null: false
      add :story_type, :string, null: false
      add :archived, :boolean, null: false
      add :blocker, :boolean, null: false
      add :blocked, :boolean, null: false
      add :started, :boolean, null: false
      add :started_at, :utc_datetime
      add :completed, :boolean, null: false
      add :completed_at, :utc_datetime
      add :created_at, :utc_datetime, null: false
      add :updated_at, :utc_datetime, null: false
      add :moved_at, :utc_datetime
    end

    create table(:story_labels, primary_key: false) do
      add :story_id, references(:stories, on_delete: :delete_all), null: false
      add :label_id, references(:labels, on_delete: :delete_all), null: false
    end

  end
end
