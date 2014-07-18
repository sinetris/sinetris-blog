use Mix.Config

config :phoenix, SinetrisBlog.Router,
  port: System.get_env("PORT") || 4001,
  host: "localhost",
  ssl: false,
  code_reload: false,
  cookies: true,
  consider_all_requests_local: true,
  session_key: "_sinetris_blog_key",
  session_secret: "ZOZY)Q6PIV20G@+*!1H=HF2O9M*HKJGIQ%NEN3=YROU$BCLV0HLQD@UWTNKGUG&*M7(SX@MSD+"

config :phoenix, :logger,
  level: :debug

config :phoenix, :database,
  url: "ecto://postgres:postgres@localhost/sinetris_blog_test?size=1&max_overflow=0"
