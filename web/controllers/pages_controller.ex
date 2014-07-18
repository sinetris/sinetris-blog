defmodule SinetrisBlog.PagesController do
  use Phoenix.Controller
  use SinetrisBlog.Helper.Application
  alias SinetrisBlog.Page

  def index(conn, _params) do
    render conn, "index", %{conn: conn, title: "Sinetris Blog"}
  end

  def show(conn, params) do
    page = Page.get(params["slug"])
    if page do
      render conn, "show", %{conn: conn, page: page}
    else
      not_found conn
    end
  end
end
