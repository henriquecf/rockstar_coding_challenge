defmodule BairesDevTest do
  use ExUnit.Case
  doctest BairesDev.LinkedInAnalysis

  describe "evaluate_person_current_role" do
    test "gives a director a 4 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_current_role(%{current_role: "director of something", points: initial_points})
      assert person.points == initial_points + 4
    end

    test "gives a manager a 3 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_current_role(%{current_role: "nice manager", points: initial_points})
      assert person.points == initial_points + 3
    end

    test "gives a senior a 2 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_current_role(%{current_role: "senior dev", points: initial_points})
      assert person.points == initial_points + 2
    end

    test "gives a someone not recgnizable a 1 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_current_role(%{current_role: "somethingthatisnotknown", points: initial_points})
      assert person.points == initial_points + 1
    end
  end
end
