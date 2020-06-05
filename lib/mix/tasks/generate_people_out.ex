defmodule Mix.Tasks.GeneratePeopleOut do
  use Mix.Task

  @shortdoc "Create a file data/people.out with the 100 best matches of data/people.in"
  def run(_) do
    result = BairesDev.LinkedInAnalysis.get_best_100_matches("data/people.in")
    result_ids = result
      |> Enum.map(&Map.get(&1, :person_id))
      |> Enum.join("\n")
    File.write!("data/people.out", result_ids)
    IO.puts("The 100 best people are in data/people.out")
  end
end


