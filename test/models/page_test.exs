defmodule SinetrisBlog.PageTest do
  use SinetrisBlogTest.Case
  alias SinetrisBlog.User
  alias SinetrisBlog.Page

  setup do
    user_params = Factory.attributes_for(:user)
    page_params = Factory.attributes_for(:page)
    {:ok, user} = User.create(user_params)
    {:ok, user: user, page_params: page_params}
  end

  test "a page must have a title", ctx do
    params = Dict.put(ctx[:page_params], :title, nil)
    assert {:error, %{title: "can't be blank"}} = Page.create(ctx[:user], params)
  end

  test "create valid page", ctx do
    assert {:ok, _page} = Page.create(ctx[:user], ctx[:page_params])
  end

  test "update user with valid data", ctx do
    assert { :ok, original_page } = Page.create(ctx[:user], ctx[:page_params])
    Page.update(original_page, [title: original_page.title<>"new"])

    page = Page.get(original_page.slug)
    refute page.title == original_page.title
  end
end
