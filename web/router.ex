defmodule SinetrisBlog.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :sinetris_blog

  plug Plug.MethodOverride

  get "/:slug", SinetrisBlog.PagesController, :show, as: :page
  get "/login", SinetrisBlog.SessionController, :new, as: :login
  post "/login", SinetrisBlog.SessionController, :create, as: :create_login
  delete "/logout", SinetrisBlog.SessionController, :destroy
  get "/", SinetrisBlog.PagesController, :index, as: :root
  scope path: "admin", alias: SinetrisBlog.Admin, helper: "admin" do
    resources "pages", PagesController
  end
end
