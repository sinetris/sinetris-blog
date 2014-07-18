defmodule Factory.User do
  use FactoryGirlElixir.Factory

  factory :user do
    field :username, &("username#{&1}")
    field :password, "secret"
    field :email, &("user#{&1}@example.com")
  end
end
