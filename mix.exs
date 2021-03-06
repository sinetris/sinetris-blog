defmodule SinetrisBlog.Mixfile do
  use Mix.Project

  def project do
    [ app: :sinetris_blog,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: ["lib", "web"],
      compilers: [:phoenix] ++ Mix.compilers,
      aliases: aliases(Mix.env),
      test_coverage: [tool: ExCoveralls],
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: { SinetrisBlog, [] },
      applications: applications(Mix.env)
    ]
  end

  defp applications do
    [
      :phoenix,
      :cowboy,
      :logger,
      :plug,
      :bcrypt,
      :postgrex,
      :ecto
    ]
  end

  defp applications(:test) do
    applications ++ [
      :hound,
      :factory_girl_elixir
    ]
  end

  defp applications(_), do: applications


  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 0.6.0"},
      {:cowboy, "~> 1.0"},
      {:bcrypt, github: "opscode/erlang-bcrypt"},
      {:postgrex, "~> 0.5"},
      {:ecto, "~> 0.2.0"}
    ]
  end

  defp deps(:test) do
    deps ++ [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.1", optional: true},
      {:hound, "~> 0.5.8"},
      {:jsex,    "~> 2.0"},
      {:excoveralls, "~> 0.3"},
      {:factory_girl_elixir, "~> 0.1.1"}
    ]
  end

  defp deps(_), do: deps

  defp aliases do
    []
  end

  defp aliases(:prod) do
    aliases ++ ['deps.get': ["deps.get", &compile_css/1]]
  end

  defp aliases(_), do: aliases

  defp compile_css(_) do
    script_file = Path.join(__DIR__, "deploy/post_app")
    Mix.shell.cmd(script_file)
  end
end
