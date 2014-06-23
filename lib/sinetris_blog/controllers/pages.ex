defmodule SinetrisBlog.Controllers.Pages do
  use Phoenix.Controller
  alias SinetrisBlog.User
  alias Plug.Conn

  def index(conn) do
    username = conn
               |> Conn.fetch_session
               |> Conn.get_session(:username)
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
