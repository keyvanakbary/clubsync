defmodule ClubhousexTest do
  use ExUnit.Case

  @oldest_datetime DateTime.from_unix!(0)

  test "greets the world" do
    # Clubhousex.search_stories("created:2011-11-20..*")
    #   |> Enum.take(2)
    #   |> IO.inspect()

    {:ok, stories} =
      Clubhousex.stories_search(
        created_at_start: @oldest_datetime,
        created_at_end: DateTime.utc_now()
      )
      # |> Enum.take(2)
      |> IO.inspect()

    stories |> Enum.count() |> IO.inspect()

    # assert Clubhousex.get_labels() == []
    # assert Clubhousex.get_projects() == []
  end
end
