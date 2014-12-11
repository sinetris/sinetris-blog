defmodule SinetrisBlog.View do
  use Phoenix.View, root: "web/templates"

  # The quoted expression returned by this block is applied
  # to this module and all other views that use this module.
  using do
    quote do
      # Import common functionality
      import SinetrisBlog.I18n
      import SinetrisBlog.Router.Helpers

      # Use Phoenix.HTML to import all HTML functions (forms, tags, etc)
      use Phoenix.HTML

      # Common aliases
      alias Phoenix.Controller.Flash
    end
  end

  # Functions defined here are available to all other views/templates
  def format_error(error) when is_binary(error) do
    {:safe, "<li>#{error}</li>"}
  end
  def format_error(errors) when is_map(errors) do
    Enum.map(errors, &format_error/1)
  end
  def format_error({k, v}) do
    {:safe, "<li>#{k} #{v}</li>"}
  end

  def make_menu do
    menu = SinetrisBlog.Menu.get_by_title("main")
    menu_items = case menu do
      %SinetrisBlog.Menu{} -> menu.menu_items.all
      _ -> []
    end
    case menu_items do
      [] -> ""
      items ->
        Enum.map(items, &({:safe, "<li><a href=\"#{&1.url}\">#{&1.title}</a></li>"}))
    end
  end
end
