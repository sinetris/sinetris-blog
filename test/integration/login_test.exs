defmodule SinetrisBlog.LoginTest do
  use SinetrisBlogTest.Case
  use Hound.Helpers

  alias SinetrisBlog.User
  alias SinetrisBlog.Router

  hound_session

  setup do
    user_params = Factory.User.attributes_for(:user)
    { :ok, _user } = User.create(user_params)
    { :ok, user_params: user_params }
  end

  test "can login with valid credential", ctx do
    navigate_to(Router.login_url)
    assert page_title() == "Login"
    find_element(:name, "username")
    |> fill_field(ctx[:user_params][:username])
    find_element(:name, "password")
    |> fill_field(ctx[:user_params][:password])
    find_element(:name, "submit")
    |> click
    element_id = find_element(:link_text, "Logout")
    assert element_displayed?(element_id) == true
  end
end
