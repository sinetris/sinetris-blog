defmodule SinetrisBlog.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :sinetris_blog

  plug Plug.Session, store: :cookie, key: "_sinetris_blog_session", secret: SinetrisBlog.Config.env.session[:secret]

  get "/:page", SinetrisBlog.Controllers.Pages, :show, as: :page
  get "/", SinetrisBlog.Controllers.Pages, :index, as: :root
end
