defmodule LiveViewUI.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :live_view_ui,
      version: @version,
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "LiveView UI",
      source_url: "https://github.com/rosaan/live_view_ui",
      docs: [
        main: "LiveView UI",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      # UI related
      {:phoenix_live_view, "~> 0.18"},
      {:lucide_live_view, "~> 0.1.0"},
      {:tails, "~> 0.1.10"},
      {:cva, "~> 0.2"},

      # Docs
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},

      # Formatting
      {:styler, "~> 0.11", only: [:dev, :test], runtime: false}
    ]
  end
end
