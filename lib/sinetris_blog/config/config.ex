defmodule SinetrisBlog.Config do
  use Phoenix.Config.App

  config :router, port: System.get_env("PORT")

  config :plugs, code_reload: false

  config :logger, level: :error

  config :session, secret: String.duplicate("abcdef0123456789", 8)
end
