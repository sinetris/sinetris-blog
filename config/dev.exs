use Mix.Config

config :phoenix, SinetrisBlog.Router,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true

# Enables code reloading for development
config :phoenix, :code_reloader, true

config :phoenix, :database,
  url: "ecto://postgres:postgres@localhost/sinetris_blog_dev"
