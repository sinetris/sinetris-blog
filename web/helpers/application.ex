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
          |> put_status(403)
          |> text("403 Unauthorized")
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

      def sanitize_params(model, params) do
        # __MODULE__.__schema__(:associations)
        valid_fields = List.delete(model.__schema__(:field_names), model.__schema__(:primary_key))
        |> Enum.map(&to_string/1)
        params
        |> Enum.filter(fn {k, _v} -> Enum.find(valid_fields, &(&1 == k)) end)
        |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
        |> Enum.into(%{})
      end
    end
  end
end
