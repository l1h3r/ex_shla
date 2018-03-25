defmodule ExShlaTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExShla.{
    Meta,
    Resource.Character,
    Resource.Episode,
    Resource.Location
  }

  @invalid_num "Hey! that parameter is not allowed, try with a number instead ;)"

  setup_all do
    {:ok, _} = HTTPoison.start()
    :ok
  end

  def assert_pagination(name, count, pages) do
    use_cassette "#{name}.all.pagination" do
      assert {:ok, result} = apply(ExShla, name, [])

      meta = Map.get(result, :meta)
      data = Map.get(result, :data)

      assert %Meta{} = meta
      assert meta.count == count
      assert meta.pages == pages
      assert Enum.count(data) == 20
    end
  end

  def assert_filter(name, count, {key, value}) do
    use_cassette "#{name}.filter.#{key}" do
      assert {:ok, result} = apply(ExShla, name, [[{key, value}]])

      data = Map.get(result, :data)

      assert Enum.count(data) == count

      Enum.each(data, fn resource ->
        assert Map.has_key?(resource, key)
        assert Map.get(resource, key) =~ ~r/#{value}/i
      end)
    end
  end

  describe "info" do
    test "returns API urls" do
      use_cassette "info" do
        data = ExShla.info()

        assert Map.has_key?(data, :characters)
        assert Map.has_key?(data, :episodes)
        assert Map.has_key?(data, :locations)
      end
    end
  end

  describe "characters" do
    test "character/1 returns a character by id" do
      use_cassette "characters.one" do
        assert {:ok, %Character{name: "Rick Sanchez", id: 1}} = ExShla.character(1)
        assert {:ok, %Character{name: "Armothy", id: 25}} = ExShla.character(25)
      end
    end

    test "character/1 returns error when invalid id" do
      use_cassette "characters.badid" do
        assert {:error, "Character not found"} = ExShla.character(-1)
        assert {:error, @invalid_num} = ExShla.character("test")
      end
    end

    test "characters/0 returns all characters with pagination" do
      assert_pagination(:characters, 394, 20)
    end

    test "characters/1 filters by name" do
      assert_filter(:characters, 20, {:name, "morty"})
    end

    test "characters/1 filters by status" do
      assert_filter(:characters, 20, {:status, "alive"})
    end

    test "characters/1 filters by species" do
      assert_filter(:characters, 20, {:species, "alien"})
    end

    test "characters/1 filters by type" do
      assert_filter(:characters, 2, {:type, "cyborg"})
    end

    test "characters/1 filters by gender" do
      assert_filter(:characters, 20, {:gender, "female"})
    end
  end

  describe "episodes" do
    test "episode/1 returns an episode by id" do
      assert {:ok, %Episode{name: "Pilot", id: 1}} = ExShla.episode(1)
      assert {:ok, %Episode{name: "The ABC's of Beth", id: 30}} = ExShla.episode(30)
    end

    test "episode/1 returns error when invalid id" do
      use_cassette "episodes.badid" do
        assert {:error, "Episode not found"} = ExShla.episode(-1)
        assert {:error, @invalid_num} = ExShla.episode("test")
      end
    end

    test "episodes/0 returns all episodes with pagination" do
      assert_pagination(:episodes, 31, 2)
    end

    test "episodes/1 filters by name" do
      assert_filter(:episodes, 13, {:name, "rick"})
    end

    test "episodes/1 filters by episode" do
      assert_filter(:episodes, 11, {:episode, "s01"})
    end
  end

  describe "locations" do
    test "location/1 returns a location by id" do
      assert {:ok, %Location{name: "Earth (C-137)", id: 1}} = ExShla.location(1)
      assert {:ok, %Location{name: "Kyle's Teenyverse", id: 50}} = ExShla.location(50)
    end

    test "location/1 returns error when invalid id" do
      use_cassette "locations.badid" do
        assert {:error, "Location not found"} = ExShla.location(-1)
        assert {:error, @invalid_num} = ExShla.location("test")
      end
    end

    test "locations/0 returns all locations with pagination" do
      assert_pagination(:locations, 67, 4)
    end

    test "locations/1 filters by name" do
      assert_filter(:locations, 18, {:name, "earth"})
    end

    test "locations/1 filters by type" do
      assert_filter(:locations, 20, {:type, "planet"})
    end

    test "locations/1 filters by dimension" do
      assert_filter(:locations, 4, {:dimension, "c-137"})
    end
  end
end
