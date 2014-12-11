defmodule Repo.Migrations.CreateMenus do
  use Ecto.Migration

  def up do
    "CREATE TABLE menus (
     id serial PRIMARY KEY,
     author_id integer REFERENCES users,
     title text,
     created_at timestamp,
     updated_at timestamp)"
  end

  def down do
    "DROP TABLE IF EXISTS menus"
  end
end
