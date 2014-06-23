defmodule SinetrisBlog.Mixfile do
  use Mix.Project

  def project do
    [ app: :sinetris_blog,
      version: "0.0.1",
      elixir: "~> 0.14.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { SinetrisBlog, [] },
      applications: [
        :phoenix,
        :plug,
        :bcrypt,
        :postgrex,
        :ecto
      ]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:plug, github: "elixir-lang/plug", override: true},
      {:phoenix, github: "sinetris/phoenix", branch: "fix-views-format"},
      {:cowboy, "~> 0.10.0", github: "extend/cowboy", optional: true},
      {:bcrypt, github: "opscode/erlang-bcrypt"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 0.2.0"}
    ]
  end
end
