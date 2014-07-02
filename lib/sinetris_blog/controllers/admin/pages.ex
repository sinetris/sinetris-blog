defmodule SinetrisBlog.Controllers.Admin.Pages do
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

  def create(conn, _params) do
    authorize(conn)
    result = current_user(conn) |> Page.create(conn.params["slug"], conn.params["title"], conn.params["body"])
    case result do
      { :ok, page } ->
        redirect conn, Router.admin_page_path(slug: page.slug)
      { :error, errors } ->
        page = %Page{title: conn.params["title"], slug: conn.params["slug"], body: conn.params["body"]}
        render conn, "new", %{conn: conn, page: page, errors: errors}
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

  def update(conn, _params) do
    authorize(conn)
    page = Page.get(conn.params["id"])
    result = Page.update(page, conn.params["slug"], conn.params["title"], conn.params["body"])
    case result do
      { :ok, page } ->
        redirect conn, Router.admin_page_path(slug: page.slug)
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
end
