defmodule SinetrisBlog.Config.Dev do
  use SinetrisBlog.Config

  config :router, port: 4000,
                  ssl: false,
                  # Full error reports are enabled
                  consider_all_requests_local: true

  config :plugs, code_reload: true

  config :logger, level: :debug

  config :database, url: "ecto://postgres:postgres@localhost/sinetris_blog_dev"
end
