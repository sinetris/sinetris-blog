defmodule SinetrisBlog.MenuTest do
  use SinetrisBlogTest.Case
  alias SinetrisBlog.User
  alias SinetrisBlog.Menu
  alias SinetrisBlog.MenuItem

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

  test "can add items to a menu", ctx do
    assert { :ok, menu } = Menu.create(ctx[:user], ctx[:menu_params])
    item_params = Factory.attributes_for(:menu_item)
    assert { :ok, %MenuItem{} } = MenuItem.create(menu, item_params)
  end

  test "a menu item must belong to a menu" do
    item_params = Factory.attributes_for(:menu_item)
    assert {:error, %{menu: "can't be blank"}} = MenuItem.create(nil, item_params)
  end

  test "get a menu and items by menu id", ctx do
    { :ok, menu } = Menu.create(ctx[:user], ctx[:menu_params])
    item_params1 = Factory.attributes_for(:menu_item, title: "Second", position: 2)
    { :ok, %MenuItem{} } = MenuItem.create(menu, item_params1)
    item_params2 = Factory.attributes_for(:menu_item, title: "First", position: 1)
    { :ok, _item2 } = MenuItem.create(menu, item_params2)
    menu1 = MenuItem.get_menu(menu.id)
    assert 2 = length menu1
    assert item_params2[:title] == hd(menu1).title
  end
end
