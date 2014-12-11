defmodule Repo.Migrations.CreateMenuItems do
  use Ecto.Migration

  def up do
    "CREATE TABLE menu_items (
     id serial PRIMARY KEY,
     menu_id integer REFERENCES menus,
     title text,
     url text,
     position integer,
     created_at timestamp,
     updated_at timestamp)"
  end

  def down do
    "DROP TABLE IF EXISTS menu_items"
  end
end
