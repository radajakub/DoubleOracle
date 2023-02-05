# DoubleOracle

Solving *two-player zero-sum Normal-Form games* by **Linear programming** and **DoubleOracle algorithm**.

## Installation

No additional installation steps are required, the julia package manager manages everything automatically.

This package uses the *Coin-Or* linear optimizer, which is downloaded automatically by `julia` when adding the package.
This optimizer can be viewed at [github](https://github.com/jump-dev/Clp.jl).

## Documentation

Documentation is present directly in the source code files as docstrings.
Moreover, a version generated by `Documenter.jl` is hosted on *GithubPages* on url: [https://radajakub.github.io/DoubleOracle/](https://radajakub.github.io/DoubleOracle/)
Visit this site to see descriptions of functions and methods together with examples.

## Prepared scripts

There are few prepared scripts in the `scripts` directory to demonstrate functionality.

User can use one of three scripts to solve a game which complies with the description in [documentation](https://radajakub.github.io/DoubleOracle/).
The game can be either passed from a text file by an optional first parameter to the scripts, or a random game will be generated if no `path_to_input_file` is specified.
The format of the input file can be deduced from example games located in `data/nf_games/`.
The parameters of the random generator can be edited directly in the scripts.

These scripts run the given algorithm(s) and print the output to `stdout`.

- `solve_nf_lp.jl [path_to_input_file]` solves a game using *Linear programming*.

    - for example to solve **Matching pennies** by *Linear programming* use: `julia solve_nf_lp.jl ../data/nf_games/matching_pennies.nfg`

- `solve_nf_do.jl [path_to_input_file]` solves a game using the *Double Oracle algorithm*.

    - for example to solve **Matching pennies** use: `julia solve_nf_do.jl ../data/nf_games/matching_pennies.nfg`

- `solve_nf_both.jl [path_to_input_file]` solves a game using the *Linear programming* and *Double Oracle algorithm*.

    - for example to solve **Matching pennies** use: `julia solve_nf_both.jl ../data/nf_games/matching_pennies.nfg`

Another script is provided, however not meant for user usage.
- `benchmark.jl` was used to generate plots visible in the documentation. It's execution takes some long time, it does not showcase any functionality, it only measures performance.

## Tests

Test can be run by executing `test` in package manager mode in `julia REPL`.
Also, they are run automatically on each push or pull request to `master` branch via *GitHub Actions*.
Past reports can be seen in the `GitHub Actions` tab of this repository.
