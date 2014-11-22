defmodule SinetrisBlog.PagesController do
  use SinetrisBlog.Helper.Application
  alias SinetrisBlog.Page

  plug :action

  def index(conn, _params) do
    render conn, "index.html", %{title: "Sinetris Blog"}
  end

  def show(conn, params) do
    page = Page.get(params["slug"])
    if page do
      render conn, "show.html", %{page: page}
    else
      not_found conn
    end
  end

  def error(conn, _params) do
    render conn, "error.html"
  end
end
