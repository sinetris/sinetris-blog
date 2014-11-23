defmodule SinetrisBlog.Admin.PagesController do
  use SinetrisBlog.Helper.Application
  alias SinetrisBlog.Page

  plug :authorize
  plug :action

  def index(conn, _params) do
    pages = Page.all
    render conn, "index.html", %{title: "Sinetris Blog Pages", pages: pages}
  end

  def show(conn, _params) do
    page = Page.get(conn.params["id"])
    if page do
      render conn, "show.html", %{page: page}
    else
      not_found conn
    end
  end

  def new(conn, _params) do
    page = %Page{}
    render conn, "new.html", %{page: page}
  end

  def create(conn, params) do
    sanitized_params = sanitize_params(Page, params)
    result = conn.assigns[:current_user] |> Page.create(sanitized_params)
    case result do
      { :ok, page } ->
        conn
        |> Flash.put(:notice, "Created #{page.title} page")
        |> redirect to: Router.Helpers.admin_page_path(:show, page.slug)
      { :error, errors } ->
        render conn, "new.html", %{page: sanitized_params, errors: errors}
    end
  end

  def edit(conn, _params) do
    page = Page.get(conn.params["id"])
    if page do
      render conn, "edit.html", %{page: page}
    else
      not_found conn
    end
  end

  def update(conn, params) do
    page = Page.get(conn.params["id"])
    sanitized_params = sanitize_params(Page, params)
    result = Page.update(page, sanitized_params)
    case result do
      { :ok, page } ->
        conn
        |> Flash.put(:notice, "Updated #{page.title} page")
        |> redirect to: Router.Helpers.admin_page_path(:show, page.slug)
      { :error, errors } ->
        render conn, "edit.html", %{page: page, errors: errors}
    end
  end

  def destroy(conn, _params) do
    if page = Page.get(conn.params["id"]) do
      Repo.delete(page)
      conn
      |> Flash.put(:notice, "Deleted #{page.title} page")
      |> redirect to: Router.Helpers.admin_page_path(:index)
    else
      not_found conn
    end
  end
end
