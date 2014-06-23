defmodule SinetrisBlog.Controllers.Session do
  use Phoenix.Controller
  alias Sinetris.Cookies
  alias SinetrisBlog.User
  alias SinetrisBlog.Router

  def show(conn) do
    render conn, "show", %{title: "Login", error: false}
  end

  def new(conn) do
    user = User.get(conn.params["username"])
    if User.auth?(user, conn.params["password"]) do
      conn
      |> Cookies.set_cookie(:username, user.username)
      |> redirect Router.root_path
    else
      render conn, "show", %{title: "Login", error: true}
    end
  end

  def destroy(conn) do
    conn
    |> Cookies.delete_cookie(:username)
    |> redirect Router.root_path
  end
end
