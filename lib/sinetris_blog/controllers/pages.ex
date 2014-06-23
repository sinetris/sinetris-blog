defmodule SinetrisBlog.Controllers.Pages do
  use Phoenix.Controller
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
    render conn, :html, "show", %{title: "Sinetris", page: conn.params["page"]}
  end
end
