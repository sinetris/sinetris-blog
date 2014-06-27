defmodule Repo.Migrations.CreatePages do
  use Ecto.Migration

  def up do
    [
      "CREATE TABLE pages (
        id serial PRIMARY KEY,
        author_id integer REFERENCES users,
        slug text UNIQUE,
        title text,
        body text,
        created_at timestamp,
        updated_at timestamp)",
      "CREATE UNIQUE INDEX ON pages (lower(slug))"
    ]
  end

  def down do
    "DROP TABLE IF EXISTS pages"
  end
end
