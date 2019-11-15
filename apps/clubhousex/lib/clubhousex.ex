defmodule Clubhousex do
  use Tesla

  adapter(Tesla.Adapter.Hackney, recv_timeout: 30_000)

  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.BaseUrl, "https://api.clubhouse.io/api/v3")

  plug(Tesla.Middleware.Query, token: Application.get_env(:clubhousex, :clubhouse_api_token))

  plug(Tesla.Middleware.Logger)

  plug(Tesla.Middleware.Retry,
    delay: 10000,
    max_retries: 5,
    max_delay: 10000,
    should_retry: fn
      {:ok, %{status: status}} when status in [429, 500] -> true
      {:ok, _} -> false
      {:error, _} -> true
    end
  )

  alias Clubhousex.{Label, Project, Story}

  @doc """
  Query parameter has to follow search operators https://help.clubhouse.io/hc/en-us/articles/360000046646-Search-Operators
  """
  # def search_stories(query, page_size \\ 25) do
  #   ("/api/v3/search/stories?" <> URI.encode_query(query: query, page_size: page_size))
  #   |> stream_get()
  #   |> Stream.map(&parse_stories/1)
  # end

  # defp parse_stories({:ok, %{status: 200, body: %{"data" => stories}}}) do
  #   {:ok, Enum.map(stories, &Story.from_map/1)}
  # end

  def stories_search(params \\ %{})
  def stories_search(params) when is_list(params), do: params |> Map.new() |> stories_search()

  def stories_search(params) when is_map(params) do
    normalised = params |> Enum.into(%{}, &normalise/1)

    "/stories/search"
    |> post(normalised)
    |> parse_stories()
  end

  defp normalise(%DateTime{} = datetime), do: DateTime.to_iso8601(datetime)
  defp normalise(value), do: value

  defp parse_stories({:ok, %{status: 201, body: stories}}) when is_list(stories) do
    {:ok, Enum.map(stories, &Story.from_map/1)}
  end

  defp parse_stories({_, %{body: body}}), do: {:error, body}

  def get_labels() do
    "/labels"
    |> get()
    |> parse_labels()
  end

  defp parse_labels({:ok, %{status: 200, body: labels}}) do
    {:ok, Enum.map(labels, &Label.from_map/1)}
  end

  defp parse_labels({_, %{body: body}}), do: {:error, body}

  def get_projects() do
    "/projects"
    |> get()
    |> parse_projects()
  end

  defp parse_projects({:ok, %{status: 200, body: projects}}) do
    {:ok, Enum.map(projects, &Project.from_map/1)}
  end

  defp parse_projects({_, %{body: body}}), do: {:error, body}

  # defp stream_get(url) do
  #   Stream.resource(
  #     fn -> url end,
  #     fn
  #       nil ->
  #         {:halt, nil}

  #       url ->
  #         result = get(url)

  #         {[result], next_url(result)}
  #     end,
  #     fn a -> a end
  #   )
  # end

  # defp next_url({:ok, %{body: %{"next" => next}}}) when is_binary(next) do
  #   next
  # end

  # defp next_url(_), do: nil
end
