defmodule SinetrisBlog.Admin.MenuItemsController do
  use SinetrisBlog.Helper.Application
  alias SinetrisBlog.Menu
  alias SinetrisBlog.MenuItem

  plug :authorize
  plug :action

  def create(conn, params) do
    menu = Menu.get(conn.params["menus_id"])
    sanitized_params = sanitize_params(MenuItem, params)
    result = MenuItem.create(menu, sanitized_params)
    case result do
      { :ok, menu_item } ->
        conn
        |> Flash.put(:notice, "Created #{menu_item.title} menu")
        |> redirect to: Router.Helpers.admin_menus_path(:show, params["menus_id"])
      { :error, errors } ->
        conn
        |> Flash.put(:error, errors)
        |> redirect to: Router.Helpers.admin_menus_path(:show, params["menus_id"])
    end
  end

  def update(conn, params) do
    menu_item = MenuItem.get(conn.params["id"])
    sanitized_params = sanitize_params(MenuItem, params)
    result = MenuItem.update(menu_item, sanitized_params)
    case result do
      { :ok, menu_item } ->
        conn
        |> Flash.put(:notice, "Updated #{menu_item.title} menu")
        |> redirect to: Router.Helpers.admin_menus_path(:show, params["menus_id"])
      { :error, errors } ->
        conn
        |> Flash.put(:error, errors)
        |> redirect to: Router.Helpers.admin_menus_path(:show, params["menus_id"])
    end
  end

  def destroy(conn, params) do
    if menu_item = MenuItem.get(conn.params["id"]) do
      Repo.delete(menu_item)
      conn
      |> Flash.put(:notice, "Deleted menu item")
      |> redirect to: Router.Helpers.admin_menus_path(:show, params["menus_id"])
    else
      put_status(conn, :not_found)
    end
  end
end
