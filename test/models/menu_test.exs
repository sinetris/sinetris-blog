defmodule SinetrisBlog.MenuTest do
  use SinetrisBlogTest.Case
  alias SinetrisBlog.User
  alias SinetrisBlog.Menu

  setup do
    user_params = Factory.attributes_for(:user)
    menu_params = Factory.attributes_for(:menu)
    {:ok, user} = User.create(user_params)
    {:ok, user: user, menu_params: menu_params}
  end

  test "create menu", ctx do
    assert { :ok, %Menu{} } = Menu.create(ctx[:user], ctx[:menu_params])
  end

  test "a menu must belong to a user", ctx do
    assert {:error, %{author: "can't be blank"}} = Menu.create(nil, ctx[:menu_params])
  end

  test "a menu must have a title", ctx do
    params = Dict.put(ctx[:menu_params], :title, nil)
    assert {:error, %{title: "can't be blank"}} = Menu.create(ctx[:user], params)
  end
end
