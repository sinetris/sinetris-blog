use Mix.Config

config :phoenix,
  routers: [
    [
      endpoint: SinetrisBlog.Router,
      port: System.get_env("PORT") |> String.to_integer,
      host: System.get_env("HOST") || "localhost",
      proxy_url: System.get_env("HOST"),
      ssl: false,
      plugs: [
        code_reload: false,
        cookies: true
      ],
      cookies: [
        key: "_sinetris_blog_key",
        secret: System.get_env("SESSION_SECRET") || "D7M@577EO)LT8_CY=WGS0(JMR5P7^$OK&+UU)X1X2X1!%CE*+ODY=3)OBU5+EYK1GUI+D4dev"
      ]
    ]
  ],
  logger: [
    level: :error
  ],
  # database: [
  #   url: System.get_env("DATABASE_URL")
  # ]
  database: [
    url: "ecto://postgres:postgres@localhost/sinetris_blog_dev"
  ]
