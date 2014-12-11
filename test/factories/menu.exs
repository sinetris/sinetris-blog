defmodule Factory.Menu do
  use FactoryGirlElixir.Factory

  factory :menu do
    field :title, &("Title #{&1}")
  end
end
