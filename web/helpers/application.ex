defmodule SinetrisBlog.Helper.Application do
  defmacro __using__(_options) do
    quote do
      use Phoenix.Controller
      alias SinetrisBlog.Router

      plug :set_current_user

      import unquote(__MODULE__)

      def authorize(conn, _options) do
        if conn.assigns[:current_user] do
          conn
        else
          conn
          |> text(:unauthorized, "403 Unauthorized")
          |> halt!
        end
      end

      def set_current_user(conn, _options) do
        user = conn
        |> Plug.Conn.fetch_session
        |> Plug.Conn.get_session(:username)
        |> SinetrisBlog.User.get
        assign(conn, :current_user, user)
      end

      def not_found(conn) do
        text conn, :not_found, "404 Not Found"
      end
    end
  end
end
