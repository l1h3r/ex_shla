defmodule LazFix do
  @moduledoc """
  Lazy JSON fixtures
  """
  require Logger
  use GenServer

  @type level :: :debug | :warn | :info | :error
  @type state :: %{path: binary, data: map}

  @messages [
    {:generate, {:info, "Generating Fixture"}},
    {:load_error, {:error, "Failed to load fixtures"}},
    {:write_error, {:error, "Failed to write fixtures"}},
    {:decode_error, {:error, "Failed to decode JSON"}},
  ]

  @path "fixtures/data.json"

  # ====== #
  # Client #
  # ====== #

  @spec start_link(opts :: keyword) :: GenServer.on_start()
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @spec get(url :: binary, getter :: fun) :: map
  def get(url, getter) do
    GenServer.call(__MODULE__, {:get, url, getter})
  end

  # ====== #
  # Server #
  # ====== #

  @spec init(opts :: keyword) :: {:ok, state}
  def init(opts) do
    Process.flag(:trap_exit, true)

    path =
      opts
      |> Keyword.get(:path, @path)
      |> Path.expand()

    {:ok, %{path: path, data: load(path)}}
  end

  def handle_call({:get, url, getter}, _, %{data: data} = state) do
    fixture = Map.get_lazy(data, url, fn ->
      :ok = log(:generate, url, :ok)

      getter.()
    end)

    state = put_in(state, [:data, url], fixture)

    {:reply, atomize!(fixture), state}
  end

  def terminate(reason, %{path: path, data: data}) do
    :ok = dump(path, data)

    reason
  end

  # ======= #
  # Private #
  # ======= #

  @spec load(path :: binary) :: map
  defp load(path) do
    with {:ok, binary} <- File.read(path),
         {:ok, data} <- Poison.decode(binary) do
      data
    else
      {:error, reason} ->
        log(:load_error, reason)
      {:error, reason, _} ->
        log(:decode_error, reason)
    end
  end

  @spec dump(path :: binary, state :: state) :: :ok | :error
  defp dump(path, state) do
    with {:ok, json} <- Poison.encode(state),
         :ok <- File.write(path, json) do
      :ok
    else
      {:error, reason} ->
        log(:write_error, reason, :error)
    end
  end

  @spec atomize!(map :: map) :: map
  defp atomize!(map) when is_map(map) do
    map
    |> Poison.encode!()
    |> Poison.decode!(keys: :atoms!)
  end

  @spec log(key :: atom, reason :: any, return :: any) :: any
  defp log(key, reason, return \\ %{}) do
    {level, label} = Keyword.get(@messages, key)

    :ok = Logger.log(level, "#{label}: #{inspect(reason)}")

    return
  end
end
