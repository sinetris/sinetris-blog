defmodule SinetrisBlog.Helper.Application do
  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
    end
  end

  def current_user(conn) do
    conn
    |> Plug.Conn.fetch_session
    |> Plug.Conn.get_session(:username)
    |> SinetrisBlog.User.get
  end

  def authorize(conn) do
    if current_user(conn) do
      conn
    else
      Phoenix.Controller.text conn, 403, "403 Unauthotized"
    end
  end

  def not_found(conn) do
    Phoenix.Controller.text conn, 404, "404 Not Found"
  end
end
