defmodule SinetrisBlog.AdminPagesTest do
  use SinetrisBlogTest.Case
  use Hound.Helpers

  alias SinetrisBlog.User
  alias SinetrisBlog.Router

  hound_session

  setup do
    user_params = Factory.attributes_for(:user)
    page_params = Factory.attributes_for(:page)
    {:ok, user} = User.create(user_params)
    {:ok, user: user, page_params: page_params, user_params: user_params}
  end

  test "create valid page", ctx do
    login(ctx[:user_params])
    navigate_to(Router.new_admin_page_url)
    assert visible_text({:tag, "h1"}) == "New Page"
    find_element(:name, "title")
    |> fill_field(ctx[:page_params][:title])
    find_element(:name, "slug")
    |> fill_field(ctx[:page_params][:slug])
    find_element(:name, "body")
    |> fill_field(ctx[:page_params][:body])
    find_element(:name, "submit")
    |> click
    assert visible_text({:tag, "h1"}) == ctx[:page_params][:title]
  end

  test "can't create a page with invalid data", ctx do
    login(ctx[:user_params])
    navigate_to(Router.new_admin_page_url)
    find_element(:name, "submit")
    |> click
    assert visible_text({:tag, "h1"}) == "New Page"
    element_id = find_element(:class, "bg-warning")
    assert element_displayed?(element_id) == true
  end

  defp login(user_params) do
    navigate_to(Router.login_url)
    find_element(:name, "username")
    |> fill_field(user_params[:username])
    find_element(:name, "password")
    |> fill_field(user_params[:password])
    find_element(:name, "submit")
    |> click
  end
end
