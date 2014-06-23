defmodule SinetrisBlog.Controllers.Session do
  use Phoenix.Controller
  alias SinetrisBlog.User
  alias SinetrisBlog.Router
  alias Plug.Conn

  def show(conn) do
    render conn, :html, "show", %{title: "Login"}
  end

  def new(conn) do
    user = User.get(conn.params["username"])
    if User.auth?(user, conn.params["password"]) do
      conn
      |> Conn.fetch_session
      |> Conn.put_session(:username, user.username)
      |> redirect Router.root_path
    else
      render conn, :html, "show", %{title: "Login", error: true}
    end
  end

  def destroy(conn) do
    conn
    |> Conn.fetch_session
    |> Conn.delete_session(:username)
    |> redirect Router.root_path
  end
end
