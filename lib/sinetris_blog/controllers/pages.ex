defmodule SinetrisBlog.Controllers.Pages do
  use Phoenix.Controller
  alias Sinetris.Renderer
  alias Sinetris.Cookies
  alias SinetrisBlog.User

  def index(conn) do
    username = Cookies.get_cookie(conn, :username)
    if user = User.get(username) do
      text conn, "Hello #{user.email}!!"
    else
      text conn, "Not Hello world!! :("
    end
  end

  def show(conn) do
    Renderer.render conn, "pages/show", [title: "Sinetris", page: conn.params["page"]]
  end
end
