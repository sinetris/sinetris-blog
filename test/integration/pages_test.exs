defmodule SinetrisBlog.PagesTest do
  use SinetrisBlogTest.Case
  use Hound.Helpers

  alias SinetrisBlog.User
  alias SinetrisBlog.Page
  alias SinetrisBlog.Router

  hound_session

  setup do
    user_params = Factory.attributes_for(:user)
    page_params = Factory.attributes_for(:page)
    {:ok, user} = User.create(user_params)
    {:ok, page} = Page.create(user, page_params)
    {:ok, page: page}
  end

  test "show a valid page by slug", ctx do
    navigate_to(pages_path(:show, ctx[:page].slug) |> url)
    assert visible_text({:css, "#main"}) == ctx[:page].body
  end

  test "show 404 on invalid page slug", ctx do
    slug = ctx[:page].slug
    Repo.delete(ctx[:page])
    navigate_to(pages_path(:show, slug) |> url)
    assert visible_text({:css, "#main"}) == "The page you are looking for does not exist"
  end
end
