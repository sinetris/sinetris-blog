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
      Phoenix.Controller.text conn, :unauthorized, "403 Unauthorized"
    end
  end

  def not_found(conn) do
    Phoenix.Controller.text conn, :not_found, "404 Not Found"
  end
end
