defmodule SinetrisBlog.Mixfile do
  use Mix.Project

  def project do
    [ app: :sinetris_blog,
      version: "0.0.1",
      elixir: "~> 0.14.3",
      elixirc_paths: ["lib", "web"],
      build_per_environment: true,
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { SinetrisBlog, [] },
      applications: applications(Mix.env)
    ]
  end

  defp applications do
    [
      :phoenix,
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


  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:plug, "~> 0.5.2", github: "elixir-lang/plug", override: true},
      {:phoenix, github: "phoenixframework/phoenix"},
      {:cowboy, "~> 0.10.0", github: "extend/cowboy", optional: true},
      {:bcrypt, github: "opscode/erlang-bcrypt"},
      {:postgrex, "~> 0.5.3"},
      {:ecto, github: "elixir-lang/ecto"}
    ]
  end

  defp deps(:test) do
    deps ++ [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.0.2", optional: true},
      {:hound, github: "HashNuke/hound"},
      {:jsex,    "~> 2.0.0"},
      {:factory_girl_elixir, github: "sinetris/factory_girl_elixir"}
    ]
  end

  defp deps(_), do: deps
end
