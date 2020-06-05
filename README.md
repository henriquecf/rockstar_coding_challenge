# BairesDev

## LinkedIn Analysis

This software is intended to get a list of people and check whoever matchs better to receive an Email campaign from BairesDev.

It is written in *elixir*. To install Elixir, head over to [the official website](https://elixir-lang.org/install.html)

To run this software, head over to the console on this folder and type:

    $ iex -S mix

    iex> BairesDev.LinkedInAnalysis.get_best_100_matches("data/people.in")

In order to run the script that creates the people.out with the 100 best:

    $ mix compile
    $ mix generate_people_out

In order to run the tests:

    $ mix test


### The main files to be analyzed in the code are

- The Module that contains the logic to read the file, evaluate some fields and return the result. This file is: [lib/baires_dev.ex](lib/baires_dev.ex)
- The Module that does the testing: [test/baires_dev_test.exs](test/baires_dev_test.exs)
- The “script” that generates the people.out file: [lib/mix/tasks/generate_people_out.ex](lib/mix/tasks/generate_people_out.ex)

### Mention in which ways your algorithm could be improved.

The algorithm could be improved in each evaluation it does. A nice idea would be to allow for the marketing team to choose the fields that would be considered, let them choose what is the relevance of each value (country, position, etc) either by exact match or by a regular expression, and maybe even give some fields a multiplier to let some fields count more points than others.

Given that, the software would gather this data that was worked by the marketing team, apply the evaluation for each field, maybe apply a multiplier, calculate how much each person scored and get the highest back.

### Which additional data do you think would be relevant to improve your algorithm?

The algorithm is not so focused on the data itself, but rather in applying a number of evaluations on the data provided and summing up the points to return the higher ones.

But with that said, I suppose that knowing if that company has software development done in house would be a nice parameter, as well as the number of employees.
