defmodule SinetrisBlog.Controllers.Pages do
  use Phoenix.Controller
  use SinetrisBlog.Helper.Application
  alias SinetrisBlog.Page

  def index(conn) do
    render conn, "index", %{conn: conn, title: "Sinetris Blog"}
  end

  def show(conn) do
    page = Page.get(conn.params["slug"])
    if page do
      render conn, "show", %{conn: conn, page: page}
    else
      not_found conn
    end
  end
end
