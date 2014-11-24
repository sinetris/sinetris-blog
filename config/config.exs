# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the router
config :phoenix, SinetrisBlog.Router,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  https: false,
  secret_key_base: "4dJpXNDtVODFUhSnrcoFoDo1GfDJuOX53FbK4cvyNVojcFrCKsi00L9hFttzaR9LE5HUGl70zdUWFMtOpAN7nA==",
  catch_errors: true,
  debug_errors: false,
  error_controller: SinetrisBlog.PagesController

# Session configuration
config :phoenix, SinetrisBlog.Router,
  session: [store: :cookie,
            key: "_sinetris_blog_key"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :database,
  url: "ecto://postgres:postgres@localhost/sinetris_blog_none"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
