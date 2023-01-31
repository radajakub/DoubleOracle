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

## Tests

Test can be run by executing `test` in package manager mode in `julia REPL`.
Also, they are run automatically on each push or pull request to `master` branch via GitHub Actions.
