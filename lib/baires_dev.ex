defmodule BairesDev do
  @moduledoc """
  Documentation for `BairesDev` LinkedIn Analysis.
  """
  defmodule LinkedInAnalysis do
    @doc ~S"""
    Reads the file that is being passed as an argument.
    It streams the file so that it can be processed lazily (line by line in this case)
    After the reading, we filter to accept only the lines that are not empty and we trim each line to remove tabs.
    Later we parse the line into a person structure, giving the keys to the values, and assigning each person a points key with value 0.
    After the person is set, we start a series of evaluations to start giving points depending on the values each person has.
    We will evaluate their countries, industries and positions and give each a grade from 1 to 4.
    After that, we sort the list putting the ones with more points on top and we get 100.
    """
    def get_best_100_matches(file_path) do
      file_path
      |> File.stream!()
      |> Stream.filter(&non_empty_lines_only/1)
      |> Stream.map(&trim_line/1)
      |> Stream.map(&turn_line_into_person_map/1)
      |> Stream.map(&evaluate_person_current_role/1)
      |> Stream.map(&evaluate_person_country/1)
      |> Stream.map(&evaluate_person_industry/1)
      |> Enum.to_list()
      |> Enum.sort_by(&Map.get(&1, :points), :desc)
      |> Enum.take(100)
    end

    defp non_empty_lines_only(""), do: false
    defp non_empty_lines_only(_), do: true

    defp trim_line(str) when is_binary(str), do: String.trim(str)

    @doc ~S"""
    Parses the given `line` into a person.

    ## Examples

        iex> BairesDev.LinkedInAnalysis.turn_line_into_person_map("123|henrique|faria|dev|Brazil|Sotware Development|20|1000")
        %{
          person_id: "123", name: "henrique", last_name: "faria", current_role: "dev", country: "Brazil", industry: "Sotware Development",
          num_recommendations: "20", num_connections: "1000", points: 0
        }

    """
    def turn_line_into_person_map(line) do
      [person_id, name, last_name, current_role, country, industry, num_recommendations, num_connections] = String.split(line, "|")
      %{
        person_id: person_id, name: name, last_name: last_name,
        current_role: current_role, country: country, industry: industry,
        num_recommendations: num_recommendations, num_connections: num_connections,
        points: 0
      }
    end

    @doc ~S"""
    Sets the proper grade (from 1 to 4) based on the current role of the person.
    We give preference to the roles that are more able to make decisions in the company.
    """
    def evaluate_person_current_role(%{current_role: role, points: points} = person) do
      new_points = cond do
        String.match?(role, ~r/director/) || String.match?(role, ~r/president/) || String.match?(role, ~r/chairman/) -> 4
        String.match?(role, ~r/manager/) || String.match?(role, ~r/coordinator/) || String.match?(role, ~r/head/) -> 3
        String.match?(role, ~r/senior/) || String.match?(role, ~r/lead/) -> 2
        true -> 1
      end

      %{person | points: points + new_points}
    end

    @doc ~S"""
    Sets the proper grade (from 1 to 4) based on the country of the person.
    The preference is for countries in America, as many of the employees of the company live there.
    """
    def evaluate_person_country(%{country: country, points: points} = person) do
      most_probable = [
        "United States", "Canada", "Costa Rica", "Mexico", "Dominica", "Argentina", "Chile",
        "Brazil", "Colombia", "Uruguay", "Puerto Rico", "Venezuela", "Peru", "Ecuador", "Panama"
      ]
      good_candidates = [
        "Spain", "United Kingdom", "Germany", "Italy", "France", "Netherlands", "Sweden", "Switzerland",
        "Poland", "Belgium", "Portugal", "Ireland", "Finland", "Denmark", "Austria", "Greece", "Croatia",
        "Luxembourg"
      ]
      not_so_good = ["India", "United Arab Emirates", "Australia", "China", "Israel",
        "Japan", "Singapore", "South Africa", "Hong Kong", "Norway", "Czech Republic", "New Zealand",
        "Saudi Arabia", "Taiwan", "Slovak Republic", "Malaysia", "Russian Federation", "Bulgaria",
        "Slovenia", "Qatar", "Romania", "Hungary"
      ]
      new_points = cond do
        country in most_probable -> 4
        country in good_candidates -> 3
        country in not_so_good -> 2
        true -> 1
      end

      %{person | points: points + new_points}
    end

    @doc ~S"""
    Sets the proper grade (from 1 to 4) based on the industry of the person.
    The preference is for the ones that are more probable to have software development done inside.
    """
    def evaluate_person_industry(%{industry: industry, points: points} = person) do
      new_points = cond do
        industry in ["Computer Software", "Information Technology and Services", "Banking"] -> 4
        industry in ["Telecommunications", "Electronics", "Consumer Electronics", "Insurance"] -> 3
        industry in ["Education", "Hospitality", "Computer Hardware", "Retail", "Construction"] -> 2
        true -> 1
      end

      %{person | points: points + new_points}
    end
  end
end
