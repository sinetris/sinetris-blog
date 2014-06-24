defmodule SinetrisBlog.Controllers.Session do
  use Phoenix.Controller
  alias SinetrisBlog.User
  alias SinetrisBlog.Router
  alias Plug.Conn

  def new(conn) do
    render conn, :html, "new", %{title: "Login"}
  end

  def create(conn) do
    user = User.get(conn.params["username"])
    if User.auth?(user, conn.params["password"]) do
      conn
      |> Conn.fetch_session
      |> Conn.put_session(:username, user.username)
      |> redirect Router.root_path
    else
      render conn, :html, "new", %{title: "Login", error: true}
    end
  end

  def destroy(conn) do
    conn
    |> Conn.fetch_session
    |> Conn.delete_session(:username)
    |> redirect Router.root_path
  end
end
