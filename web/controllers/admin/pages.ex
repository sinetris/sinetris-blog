defmodule SinetrisBlog.Admin.PagesController do
  use Phoenix.Controller
  use SinetrisBlog.Helper.Application
  alias SinetrisBlog.Router
  alias SinetrisBlog.Page

  def index(conn, _params) do
    authorize(conn)
    pages = Page.all
    render conn, "index", %{conn: conn, title: "Sinetris Blog Pages", pages: pages}
  end

  def show(conn, _params) do
    authorize(conn)
    page = Page.get(conn.params["id"])
    if page do
      render conn, "show", %{conn: conn, page: page}
    else
      not_found conn
    end
  end

  def new(conn, _params) do
    authorize(conn)
    page = %Page{}
    render conn, "new", %{conn: conn, page: page}
  end

  def create(conn, params) do
    sanitized_params = sanitize_params(Page, params)
    authorize(conn)
    result = current_user(conn) |> Page.create(sanitized_params)
    case result do
      { :ok, page } ->
        redirect conn, Router.admin_page_path(id: page.slug)
      { :error, errors } ->
        render conn, "new", %{conn: conn, page: sanitized_params, errors: errors}
    end
  end

  def edit(conn, _params) do
    authorize(conn)
    page = Page.get(conn.params["id"])
    if page do
      render conn, "edit", %{conn: conn, page: page}
    else
      not_found conn
    end
  end

  def update(conn, params) do
    authorize(conn)
    page = Page.get(conn.params["id"])
    sanitized_params = sanitize_params(Page, params)
    result = Page.update(page, sanitized_params)
    case result do
      { :ok, page } ->
        redirect conn, Router.admin_page_path(id: page.slug)
      { :error, errors } ->
        render conn, "edit", %{conn: conn, page: page, errors: errors}
    end
  end

  def destroy(conn, _params) do
    if page = Page.get(conn.params["id"]) do
      Repo.delete(page)
      redirect conn, Router.admin_pages_path
    else
      not_found conn
    end
  end

  def sanitize_params(model, params) do
    # __MODULE__.__schema__(:associations)
    valid_fields = List.delete(model.__schema__(:field_names), model.__schema__(:primary_key))
    |> Enum.traverse(&to_string/1)
    params
    |> Enum.filter(fn {k, _v} -> Enum.find(valid_fields, &(&1 == k)) end)
    |> Enum.traverse(fn {k, v} -> {String.to_atom(k), v} end)
    |> Enum.into(%{})
  end

end
