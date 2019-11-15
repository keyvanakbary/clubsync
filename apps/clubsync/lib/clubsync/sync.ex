defmodule Clubsync.Sync do
  require Logger

  alias Clubsync.Store.Repo

  @oldest_datetime DateTime.from_unix!(0)

  def all() do
    sync_labels()
    sync_projects()

    now = DateTime.utc_now()
    sync_stories(now)
  end

  defp sync_labels() do
    Logger.info("Syncing labels...")

    {:ok, labels} = Clubhousex.get_labels()

    labels
      |> Repo.add_labels()
      |> log_syncs()
  end

  defp sync_projects() do
    Logger.info("Syncing projects...")

    {:ok, projects} = Clubhousex.get_projects()

    projects
      |> Repo.add_projects()
      |> log_syncs()
  end

  defp sync_stories(now) do
    Logger.info("Syncing stories...")

    last_created_at = Repo.last_story_created_at() || @oldest_datetime

    {:ok, stories} = Clubhousex.stories_search(created_at_start: last_created_at, created_at_end: now)

    stories
      |> Repo.add_stories()
      |> log_syncs()
  end

  defp log_syncs(num),
    do: Logger.info("Synced #{num}", ansi_color: :green)
end
