defmodule SinetrisBlog.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/" do
    # Use the default browser stack.
    pipe_through :browser

    get "/", SinetrisBlog.PagesController, :index, as: :pages
    get "/login", SinetrisBlog.SessionController, :new, as: :login
    post "/login", SinetrisBlog.SessionController, :create, as: :login
    delete "/logout", SinetrisBlog.SessionController, :destroy
    get "/:slug", SinetrisBlog.PagesController, :show, as: :page
    scope path: "admin", alias: SinetrisBlog.Admin, helper: "admin" do
        resources "pages", PagesController, as: :admin_pages
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api" do
  #   pipe_through :api
  # end
end
