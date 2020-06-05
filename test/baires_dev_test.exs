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

    test "gives  someone not recognizable a 1 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_current_role(%{current_role: "somethingthatisnotknown", points: initial_points})
      assert person.points == initial_points + 1
    end
  end

  describe "evaluate_person_country" do
    test "gives someone from United States a 4 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_country(%{country: "United States", points: initial_points})
      assert person.points == initial_points + 4
    end

    test "gives someone from Italy a 3 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_country(%{country: "Italy", points: initial_points})
      assert person.points == initial_points + 3
    end

    test "gives someone from China a 2 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_country(%{country: "China", points: initial_points})
      assert person.points == initial_points + 2
    end

    test "gives someone from some other places a 1 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_country(%{country: "Sudan", points: initial_points})
      assert person.points == initial_points + 1
    end
  end

  describe "evaluate_person_industry" do
    test "gives someone from Banking a 4 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_industry(%{industry: "Banking", points: initial_points})
      assert person.points == initial_points + 4
    end

    test "gives someone from Telecommunications a 3 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_industry(%{industry: "Telecommunications", points: initial_points})
      assert person.points == initial_points + 3
    end

    test "gives someone from Education a 2 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_industry(%{industry: "Education", points: initial_points})
      assert person.points == initial_points + 2
    end

    test "gives someone from Management Consulting a 1 value" do
      initial_points = 0
      person = BairesDev.LinkedInAnalysis.evaluate_person_industry(%{industry: "Management Consulting", points: initial_points})
      assert person.points == initial_points + 1
    end
  end
end
