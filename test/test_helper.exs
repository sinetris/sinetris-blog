ExUnit.start [max_cases: 1]

SinetrisBlog.Router.start

Mix.Task.run "ecto.drop", ["Repo"]
Mix.Task.run "ecto.create", ["Repo"]
Mix.Task.run "ecto.migrate", ["Repo"]

Path.join(__DIR__, "factories/*.exs")
|> Path.wildcard
|> Enum.each(&Code.require_file/1)

defmodule SinetrisBlogTest.Case do
  use ExUnit.CaseTemplate

  setup do
    :ok = Ecto.Adapters.Postgres.begin_test_transaction(Repo)
    on_exit fn ->
      :ok = Ecto.Adapters.Postgres.rollback_test_transaction(Repo)
    end
    :ok
  end

  using do
    quote do
      import SinetrisBlogTest.Case
      import SinetrisBlog.Router.Helpers
    end
  end
end
