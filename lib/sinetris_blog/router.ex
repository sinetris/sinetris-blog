defmodule SinetrisBlog.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :sinetris_blog
  get "/:page", SinetrisBlog.Controllers.Pages, :show, as: :page
  get "/", SinetrisBlog.Controllers.Pages, :index, as: :root
end
