defmodule SinetrisBlog.Config.Test do
  use SinetrisBlog.Config

  config :router, port: 4001,
                  ssl: false,
                  # Full error reports are enabled
                  consider_all_requests_local: true

  config :plugs, code_reload: true

  config :logger, level: :debug

  config :database, url: "ecto://postgres:postgres@localhost/sinetris_blog_test?size=1&max_overflow=0"
end
