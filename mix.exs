defmodule LightningCSS.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :lightning_css,
      version: @version,
      elixir: "~> 1.15",
      description:
        "A wrapper for the Lightning CSS tool.",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:modulex, "~> 0.7.0", runtime: false},
      {:boundary, "~> 0.10", runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:rustler, "~> 0.29.1"}
    ]
  end

  defp package() do
    [
      name: "lightning_css",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/glossia/lightning_css"}
    ]
  end

  defp docs() do
    [
      main: "lightning_css",
      extras: ["README.md"],
      source_url: "https://github.com/glossia/lightning_css/",
      source_ref: @version
    ]
  end
end
