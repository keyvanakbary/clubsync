use Mix.Config

config :clubsync, ecto_repos: [Clubsync.Store.Repo]

config :clubsync, Clubsync.Store.Repo,
  database: System.get_env("DB_NAME", "clubsync"),
  username: System.get_env("DB_USER", "clubsync"),
  password: System.get_env("DB_PASS", "pass"),
  hostname: System.get_env("DB_HOST", "127.0.0.1"),
  port: System.get_env("DB_PORT", "3306") |> String.to_integer()

config :clubsync, Clubsync.Scheduler,
  overlap: false,
  jobs: [
    {"* * * * *", {Clubsync.Sync, :all, []}}
  ]
