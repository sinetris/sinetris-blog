defmodule Sinetris.Renderer do
  # defmacro __using__(options) do
  #   quote do
  #     require EEx
  #     import unquote(__MODULE__)
  #   end
  # end

  def render(conn, template, assigns) do
    require EEx
    response = EEx.eval_file Path.join(["lib/sinetris_blog/views/#{template}.html.eex"]), assigns
    layout = EEx.eval_file Path.join(["lib/sinetris_blog/views/layouts/application.html.eex"]), [yeld: response] ++ assigns
    Phoenix.Controller.html conn, layout
  end
end
