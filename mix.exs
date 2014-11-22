defmodule SinetrisBlog.Mixfile do
  use Mix.Project

  def project do
    [ app: :sinetris_blog,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: ["lib", "web"],
      compilers: [:phoenix] ++ Mix.compilers,
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
      {:factory_girl_elixir, github: "sinetris/factory_girl_elixir"}
    ]
  end

  defp deps(_), do: deps
end
