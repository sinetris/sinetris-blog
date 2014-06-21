defmodule SinetrisBlog.Config.Prod do
  use SinetrisBlog.Config

  config :router, port: System.get_env("PORT"),
                  ssl: false,
                  # Full error reports are disabled
                  consider_all_requests_local: false

  config :plugs, code_reload: false

  config :logger, level: :error

  config :database, url: System.get_env("DATABASE_URL")
end
