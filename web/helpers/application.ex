defmodule SinetrisBlog.Helper.Application do
  defmacro __using__(_options) do
    quote do
      use Phoenix.Controller
      alias SinetrisBlog.Router
      alias Phoenix.Controller.Flash

      plug :set_current_user
      plug :set_flash_messages

      import unquote(__MODULE__)

      def authorize(conn, _options) do
        if conn.assigns[:current_user] do
          conn
        else
          conn
          |> text(:unauthorized, "403 Unauthorized")
          |> halt
        end
      end

      def set_current_user(conn, _options) do
        user = conn
        |> Plug.Conn.fetch_session
        |> Plug.Conn.get_session(:username)
        |> SinetrisBlog.User.get
        assign(conn, :current_user, user)
      end

      def set_flash_messages(conn, _options) do
        messages = Flash.get(conn)
        assign(conn, :flash_messages, messages)
      end

      def not_found(conn) do
        text conn, :not_found, "404 Not Found"
      end
    end
  end
end
