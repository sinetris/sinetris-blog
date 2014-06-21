defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    parse_url SinetrisBlog.Config.env.database[:url]
  end
  
  def priv do
    app_dir(:sinetris_blog, "priv/repo")
  end
end
