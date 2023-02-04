# DoubleOracle

Solving two-player zero-sum Normal-Form games by linear programming and DoubleOracle algorithm.

## Installation

No additional installation steps are required, the julia package manager manages everything automatically.

This package uses the Coin-Or linear optimizer, which is downloaded automatically by `julia` when adding the package.
This optimizer can be viewed at [github](https://github.com/jump-dev/Clp.jl).

## Documentation

Documentation is accessible in the source code directly plus a generated Documenter.jl version runs in `pages` branch on url: [https://radajakub.github.io/DoubleOracle/](https://radajakub.github.io/DoubleOracle/)

## Prepared scripts

There are few prepared scripts in the `scripts` directory to demonstrate functionality.

- `solve_nf_lp.jl [path_to_input_file]` solves a game using linear programming. The output is printed to standard output. The game is either loaded from file given by optional `path_to_input_file` or a random one is generated.

    - for example to solve **Matching pennies** use: `julia solve_nf_lp.jl ../data/nf_games/matching_pennies.nfg`

- `solve_nf_do.jl [path_to_input_file]` solves a game using the Double Oracle algorithm. The output is printed to standard output. The game is either loaded from file given by optional `path_to_input_file` or a random one is generated.

    - for example to solve **Matching pennies** use: `julia solve_nf_do.jl ../data/nf_games/matching_pennies.nfg`

- `solve_nf_both.jl [path_to_input_file]` solves a game using the Linear programming and Double Oracle algorithm. The outputs are printed to standard output. The game is either loaded from file given by optional `path_to_input_file` or a random one is generated.

    - for example to solve **Matching pennies** use: `julia solve_nf_both.jl ../data/nf_games/matching_pennies.nfg`

    The parameters for random generation can be edited in the scripts.

## Tests

Test can be run by executing `test` in package manager mode in `julia REPL`.
Also, they are run automatically on each push or pull request to `master` branch via GitHub Actions.
