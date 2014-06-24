defmodule SinetrisBlog.Controllers.Pages do
  use Phoenix.Controller
  alias SinetrisBlog.User
  alias Plug.Conn

  def index(conn) do
    username = conn
               |> Conn.fetch_session
               |> Conn.get_session(:username)
    user = User.get(username)
    render conn, :html, "index", %{title: "Sinetris Blog", user: user}
  end

  def show(conn) do
    render conn, :html, "show", %{title: "Sinetris", page: conn.params["page"]}
  end
end
