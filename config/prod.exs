use Mix.Config

config :phoenix, SinetrisBlog.Router,
  port: System.get_env("PORT"),
  host: System.get_env("HOST"),
  proxy_port: System.get_env("PROXY_PORT") || 80,
  ssl: false,
  code_reload: false,
  cookies: true,
  session_key: "_sinetris_blog_key",
  session_secret: System.get_env("SESSION_SECRET")

config :phoenix, :logger,
  level: :error

config :phoenix, :database,
  url: System.get_env("DATABASE_URL")
