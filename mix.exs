defmodule Pxblog.Mixfile do
  use Mix.Project

  def project do
    [app: :pxblog,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Pxblog, []},
     applications: app_list(Mix.env)]
  end

  defp app_list(:test), do: [:ex_machina | app_list]
  defp app_list(_), do: app_list
  defp app_list, do: [:phoenix, :phoenix_html, :cowboy, :logger, :phoenix_ecto, :postgrex, :comeonin]

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.1"},
     {:phoenix_ecto, "~> 2.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.3"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:cowboy, "~> 1.0"},
     {:comeonin, "~> 2.0"},
     {:exrm, "~> 0.19.9"},
     {:conform, "~> 0.17.0"},
     {:ex_machina, "~> 0.6"},
     {:earmark, "~> 0.1.19"}]
  end
end
