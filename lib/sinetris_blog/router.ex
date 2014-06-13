defmodule SinetrisBlog.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :sinetris_blog
  get "/", SinetrisBlog.Controllers.Pages, :index, as: :page
end
