defmodule SinetrisBlog.Controllers.Pages do
  use Phoenix.Controller
  use Sinetris.Renderer

  def index(conn) do
    text conn, "Hello world!!"
  end

  def show(conn) do
    render conn, "pages/show", [title: "Sinetris", page: conn.params["page"]]
  end

end
