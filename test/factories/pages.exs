defmodule Factory.Page do
  use FactoryGirlElixir.Factory

  factory :page do
    field :title, &("Title #{&1}")
    field :slug, &("title-#{&1}")
    field :body, "body"
  end
end
