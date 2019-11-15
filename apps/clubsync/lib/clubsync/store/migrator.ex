defmodule Clubsync.Store.Migrator do
  require Logger

  def migrate do
    Logger.info("Running migrations")

    path = Application.app_dir(:clubsync, "priv/repo/migrations")

    Ecto.Migrator.run(Clubsync.Store.Repo, path, :up, all: true)
  end
end
