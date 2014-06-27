defmodule SinetrisBlog.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :sinetris_blog

  plug Plug.MethodOverride

  plug Plug.Session, store: :cookie, key: "_sinetris_blog_session", secret: SinetrisBlog.Config.env.session[:secret]

  get "/:slug", SinetrisBlog.Controllers.Pages, :show, as: :page
  get "/login", SinetrisBlog.Controllers.Session, :new, as: :login
  post "/login", SinetrisBlog.Controllers.Session, :create, as: :create_login
  delete "/logout", SinetrisBlog.Controllers.Session, :destroy
  get "/", SinetrisBlog.Controllers.Pages, :index, as: :root
  scope path: "admin", alias: SinetrisBlog.Controllers.Admin, helper: "admin" do
    resources "pages", Pages
  end
end
