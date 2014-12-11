defmodule Factory.MenuItem do
  use FactoryGirlElixir.Factory

  factory :menu_item do
    field :title, &("Title #{&1}")
    field :url, &("/url#{&1}")
    field :position, &(&1)
  end
end
