# defmodule SinetrisBlog.AdminPagesTest do
#   use SinetrisBlogTest.Case
#   use Hound.Helpers
#
#   hound_session
#
#   test "create valid page" do
#     navigate_to(Router.new_admin_page_url)
#     assert page_title() == "Login"
#     find_element(:name, "username")
#     |> fill_field(ctx[:user_params][:username])
#     find_element(:name, "password")
#     |> fill_field(ctx[:user_params][:password])
#     find_element(:name, "submit")
#     |> click
#     element_id = find_element(:link_text, "Logout")
#     assert element_displayed?(element_id) == true
#   end
# end
