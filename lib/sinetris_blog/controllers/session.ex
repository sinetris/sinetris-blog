defmodule SinetrisBlog.Controllers.Session do
  use Phoenix.Controller
  alias SinetrisBlog.User
  alias SinetrisBlog.Router
  alias Plug.Conn

  def new(conn, _params) do
    render conn, "new", %{conn: conn, title: "Login"}
  end

  def create(conn, params) do
    user = User.get(params["username"])
    if User.auth?(user, params["password"]) do
      conn
      |> Conn.fetch_session
      |> Conn.put_session(:username, user.username)
      |> redirect Router.root_path
    else
      render conn, "new", %{conn: conn, title: "Login", error: true}
    end
  end

  def destroy(conn, _params) do
    conn
    |> Conn.fetch_session
    |> Conn.delete_session(:username)
    |> redirect Router.root_path
  end
end
