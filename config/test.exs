use Mix.Config

config :phoenix, SinetrisBlog.Router,
  http: [port: System.get_env("PORT") || 4001],
  catch_errors: false

config :phoenix, :database,
  url: "ecto://postgres:postgres@localhost/sinetris_blog_test?size=1&max_overflow=0"
