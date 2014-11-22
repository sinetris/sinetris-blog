use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :phoenix, SinetrisBlog.Router,
  url: [host: System.get_env("HOST")],
  http: [port: System.get_env("PORT"),
        proxy_port: System.get_env("PROXY_PORT") || 80],
  secret_key_base: System.get_env("SESSION_SECRET")

config :logger, :console,
  level: :info

config :phoenix, :database,
  url: System.get_env("DATABASE_URL")
