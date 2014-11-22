defmodule SinetrisBlog.SessionController do
  use SinetrisBlog.Helper.Application
  alias SinetrisBlog.User
  alias Plug.Conn

  plug :action

  def new(conn, _params) do
    render conn, "new.html"#, %{title: "Login"}
  end

  def create(conn, params) do
    user = User.get(params["username"])
    if User.auth?(user, params["password"]) do
      conn
      |> Conn.fetch_session
      |> Conn.put_session(:username, user.username)
      |> Flash.put(:notice, "Logged in as #{user.username}")
      |> redirect "/"
    else
      conn = Flash.put(conn, :warning, "Invalid credentials")
      messages = Flash.get(conn)
      render conn, "new.html", %{title: "Login", flash_messages: messages}
    end
  end

  def destroy(conn, _params) do
    conn
    |> Conn.fetch_session
    |> Conn.delete_session(:username)
    |> Flash.put(:notice, "Logged out")
    |> redirect "/"
  end
end
