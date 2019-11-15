import Config

config :clubhousex, :clubhouse_api_token, System.fetch_env!("CLUBHOUSE_API_TOKEN")

config :clubsync, Clubsync.Store.Repo,
  database: System.fetch_env!("DB_NAME"),
  username: System.fetch_env!("DB_USER"),
  password: System.fetch_env!("DB_PASS"),
  hostname: System.fetch_env!("DB_HOST"),
  port: System.get_env("DB_PORT", "3306") |> String.to_integer()

config :clubsync, Clubsync.Scheduler,
  jobs: [
    {System.get_env("CRON_SCHEDULE", "*/15 * * * *"), {Clubsync.Sync, :all, []}}
  ]
