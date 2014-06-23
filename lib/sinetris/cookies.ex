defmodule Sinetris.Cookies do
  import Plug.Conn

  def set_cookie(conn, key, val) do
    conn = fetch_session(conn)
    session = get_session(conn) || %{}
    put_session(conn, Map.put(session, key, val))
  end

  def get_cookie(conn, key) do
    conn = fetch_session(conn)
    session = get_session(conn)
    session[key]
  end

  def delete_cookie(conn, key) do
    conn = fetch_session(conn)
    session = get_session(conn) || %{}
    put_session(conn, Map.delete(session, key))
  end
end
