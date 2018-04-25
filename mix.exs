defmodule ExShla.MixProject do
  use Mix.Project

  @github "https://github.com/l1h3r/ex_shla"

  def project do
    [
      app: :ex_shla,
      version: "0.1.5",
      elixir: "~> 1.6",
      name: "ExShla",
      package: package(),
      description: description(),
      source_url: @github,
      homepage_url: @github,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:poison, "~> 3.1.0"},
      {:tesla, "~> 0.10.0"},
      {:tesla_replay, "~> 0.1.1", only: [:dev, :test]},
      {:ex_doc, "~> 0.18.3", only: :dev},
      {:excoveralls, "~> 0.8.1", only: [:dev, :test]},
      {:dialyxir, "~> 0.5.1", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.9.0-rc8", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      lint: ["dialyzer", "credo", "test"]
    ]
  end

  defp description do
    ~s(Elixir client for the Rick and Morty API.)
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["l1h3r"],
      licenses: ["MIT"],
      links: %{"Github" => @github}
    ]
  end
end
