defmodule ExShla.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_shla,
      version: "0.1.0",
      elixir: "~> 1.6",
      name: "ExShla",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      aliases: aliases(),
      dialyzer: dialyzer(),
      test_coverage: [tool: ExCoveralls],
      package: package(),
      description: description(),
      source_url: "https://github.com/l1h3r/ex_shla"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ~w(lib test/support)
  defp elixirc_paths(_), do: ~w(lib)

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1.0"},
      {:tesla, "~> 0.10.0"},
      {:ex_doc, "~> 0.18.3", only: :dev},
      {:excoveralls, "~> 0.8.1", only: [:dev, :test]},
      {:dialyxir, "~> 0.5.1", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.9.0-rc8", only: [:dev, :test], runtime: false}
    ]
  end

  # See the documentation for `Mix` for more info on aliases.
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
      links: %{"Github" => "https://github.com/l1h3r/ex_shla"}
    ]
  end

  defp dialyzer do
    [
      # ignore_warnings: "dialyzer.ignore-warnings",
      flags: [
        # Warn for functions that only return by an exception.
        :error_handling,
        # Warn about behavior callbacks that drift from the published recommended interfaces.
        :no_behaviours,
        # Warn about invalid contracts.
        :no_contracts,
        # Warn for failing calls.
        :no_fail_call,
        # Warn for fun applications that will fail.
        :no_fun_app,
        # Warn for construction of improper lists.
        :no_improper_lists,
        # Warn for patterns that are unused or cannot match.
        :no_match,
        # Warn about calls to missing functions.
        :no_missing_calls,
        # Warn for violations of opacity of data types.
        :no_opaque,
        # Warn for functions that will never return a value.
        :no_return,
        # Warn about behaviors that have no -callback attributes for their callbacks.
        :no_undefined_callbacks,
        # Warn for unused functions.
        :no_unused,
        # Warn for possible race conditions
        :race_conditions,
        # Warn about unknown functions and types affect the exit status of the CLI version.
        :unknown,
        # Warn for function calls that ignore a structured return value
        :unmatched_returns
      ]
    ]
  end
end
