defmodule SinetrisBlog.Controllers.Pages do
  use Phoenix.Controller
  alias Sinetris.Renderer

  def index(conn) do
    text conn, "Hello world!!"
  end

  def show(conn) do
    Renderer.render conn, "pages/show", [title: "Sinetris", page: conn.params["page"]]
  end

end
