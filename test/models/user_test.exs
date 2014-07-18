defmodule SinetrisBlog.UserTest do
  use SinetrisBlogTest.Case
  alias SinetrisBlog.User

  setup do
    user_params = Factory.attributes_for(:user)
    { :ok, user_params: user_params }
  end

  test "create user", ctx do
    assert { :ok, %User{} } = User.create(ctx[:user_params])
    assert User.get(ctx[:user_params][:username])
  end

  test "auth user with valid credential", ctx do
    assert { :ok, user } = User.create(ctx[:user_params])
    assert user |> User.auth?(ctx[:user_params][:password])
  end

  test "fail auth on wrong username", ctx do
    assert { :ok, %User{} } = User.create(ctx[:user_params])
    refute User.get(ctx[:user_params][:username]<>"wrong") |> User.auth?(ctx[:user_params][:password])
  end

  test "fail auth on wrong password", ctx do
    assert { :ok, %User{} } = User.create(ctx[:user_params])
    refute User.get(ctx[:user_params][:username]) |> User.auth?(ctx[:user_params][:password]<>"wrong")
  end

  test "users name and email are unique", ctx do
    assert { :ok, %User{} } = User.create(ctx[:user_params])
    # TODO: assert on { :error, errors } when fixed in model
    assert %Postgrex.Error{} = catch_error(User.create(ctx[:user_params]))
  end

  test "update user with valid data", ctx do
    assert { :ok, user } = User.create(ctx[:user_params])
    User.update(user, [email: "other@example.com", password: "new_pass"])

    user = User.get(ctx[:user_params][:username])
    assert user.email == "other@example.com"
    assert User.auth?(user, "new_pass")
    refute User.auth?(user, ctx[:user_params][:password])
  end

  test "don't change password if new password is empty", ctx do
    assert { :ok, user } = User.create(ctx[:user_params])
    User.update(user, [email: "other@example.com", password: ""])

    user = User.get(ctx[:user_params][:username])
    assert user.email == "other@example.com"
    assert User.auth?(user, ctx[:user_params][:password])
  end

end
