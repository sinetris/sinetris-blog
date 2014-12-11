defmodule SinetrisBlog.Admin.MenusController do
  use SinetrisBlog.Helper.Application
  alias SinetrisBlog.Menu

  plug :authorize
  plug :action

  def index(conn, _params) do
    menus = Menu.all
    render conn, "index.html", %{title: "Sinetris Blog Menus", menus: menus}
  end

  def show(conn, _params) do
    menu = Menu.get(conn.params["id"])
    if menu do
      render conn, "show.html", %{menu: menu}
    else
      put_status(conn, :not_found)
    end
  end

  def new(conn, _params) do
    menu = %Menu{}
    render conn, "new.html", %{menu: menu}
  end

  def create(conn, params) do
    sanitized_params = sanitize_params(Menu, params)
    result = conn.assigns[:current_user] |> Menu.create(sanitized_params)
    case result do
      { :ok, menu } ->
        conn
        |> Flash.put(:notice, "Created #{menu.title} menu")
        |> redirect to: Router.Helpers.admin_menus_path(:show, menu.id)
      { :error, errors } ->
        render conn, "new.html", %{menu: sanitized_params, errors: errors}
    end
  end

  def edit(conn, _params) do
    menu = Menu.get(conn.params["id"])
    if menu do
      render conn, "edit.html", %{menu: menu}
    else
      put_status(conn, :not_found)
    end
  end

  def update(conn, params) do
    menu = Menu.get(conn.params["id"])
    sanitized_params = sanitize_params(Menu, params)
    result = Menu.update(menu, sanitized_params)
    case result do
      { :ok, menu } ->
        conn
        |> Flash.put(:notice, "Updated #{menu.title} menu")
        |> redirect to: Router.Helpers.admin_menus_path(:show, menu.id)
      { :error, errors } ->
        render conn, "edit.html", %{menu: menu, errors: errors}
    end
  end

  def destroy(conn, _params) do
    if menu = Menu.get(conn.params["id"]) do
      Repo.delete(menu)
      conn
      |> Flash.put(:notice, "Deleted #{menu.title} menu")
      |> redirect to: Router.Helpers.admin_menus_path(:index)
    else
      put_status(conn, :not_found)
    end
  end
end
