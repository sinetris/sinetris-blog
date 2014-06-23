defmodule Sinetris.Cookies do
  import Plug.Conn

  def set_cookie(conn, key, val) do
    conn = fetch_session(conn)
    # session = get_session(conn, key) || %{}
    put_session(conn, key, val)
  end

  def get_cookie(conn, key) do
    conn = fetch_session(conn)
    session = get_session(conn, key)
    # session[key]
  end

  def delete_cookie(conn, key) do
    conn = fetch_session(conn)
    # session = get_session(conn) || %{}
    delete_session(conn, key)
  end
end
