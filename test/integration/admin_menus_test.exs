defmodule SinetrisBlog.AdminMenusTest do
  use SinetrisBlogTest.Case
  use Hound.Helpers

  alias SinetrisBlog.User
  alias SinetrisBlog.Router

  hound_session

  setup do
    user_params = Factory.attributes_for(:user)
    menu_params = Factory.attributes_for(:menu)
    {:ok, user} = User.create(user_params)
    {:ok, user: user, menu_params: menu_params, user_params: user_params}
  end

  test "create valid menu", ctx do
    login(ctx[:user_params])
    navigate_to(admin_menus_path(:new) |> url)
    assert visible_text({:tag, "h1"}) == "New Menu"
    find_element(:name, "title")
    |> fill_field(ctx[:menu_params][:title])
    find_element(:name, "submit")
    |> click
    assert visible_text({:tag, "h1"}) == ctx[:menu_params][:title]
  end

  test "can't create a menu with invalid data", ctx do
    login(ctx[:user_params])
    navigate_to(admin_menus_path(:new) |> url)
    find_element(:name, "submit")
    |> click
    assert visible_text({:tag, "h1"}) == "New Menu"
    element_id = find_element(:class, "bg-warning")
    assert element_displayed?(element_id) == true
  end

  defp login(user_params) do
    navigate_to(login_path(:new) |> url)
    find_element(:name, "username")
    |> fill_field(user_params[:username])
    find_element(:name, "password")
    |> fill_field(user_params[:password])
    find_element(:name, "submit")
    |> click
  end
end
