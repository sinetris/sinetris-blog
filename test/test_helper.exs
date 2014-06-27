ExUnit.start

Mix.Task.run "ecto.drop", ["Repo"]
Mix.Task.run "ecto.create", ["Repo"]
Mix.Task.run "ecto.migrate", ["Repo"]

defmodule SinetrisBlogTest.Case do
  use ExUnit.CaseTemplate

  alias Ecto.Adapters.Postgres

  setup do
    Postgres.begin_test_transaction(Repo)
    on_exit fn -> Postgres.rollback_test_transaction(Repo) end
    :ok
  end

  using do
    quote do
      import SinetrisBlogTest.Case
    end
  end
end
