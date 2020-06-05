# BairesDev

## LinkedIn Analysis

This software is intended to get a list of people and check whoever matchs better to receive an Email campaign from BairesDev.
It is written in *elixir*. To install Elixir, head over to [the official website](https://elixir-lang.org/install.html)
To run this software, head over to the console on this folder and type:

    $ iex -S mix
```
    iex> BairesDev.LinkedInAnalysis.get_best_100_matches("data/people.in")
```

In other to run the script that creates the people.out with the 100 best, run:

    $ mix compile
    $ mix generate_people_out

In order to test it run:

    $ mix test
