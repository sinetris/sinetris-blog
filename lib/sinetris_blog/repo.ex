defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres, env: Mix.env

  @doc "Adapter configuration"
  def conf(env), do: parse_url url(env)

  defp url(:test) do
    SinetrisBlog.Config.Test.database[:url]
  end
  defp url(_) do
    SinetrisBlog.Config.env.database[:url]
  end

  def priv do
    app_dir(:sinetris_blog, "priv/repo")
  end
end
