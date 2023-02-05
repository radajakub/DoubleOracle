```@meta
CurrentModule = DoubleOracle
```

# DoubleOracle package

Documentation for [DoubleOracle](https://github.com/radajakub/DoubleOracle) package contining solution methods for some parts of game theory using exact methods and variations of Oracle methods.

## Type of games

This package solves *two-player* *zero-sum* games in *Normal form*.
However, some parts are generalized for more than 2 players and thus the package can be easily extended for more general type of games.

*Two-player zero-sum Normal-Form games* are defined as `G = (N, A, U)`, where `N` is the set of players (`|N| = 2`), `A = (A1, A2)` is the set of actions for both players and `U` is the payoff matrix.
The matrix `U` has `|A1|` rows and `|A2|` columns.
Each element of the matrix corresponds to payoff received by player 1 when joint action profile `(a1, a2)` is played by both players.
The opponent recieves this payoff multiplied by -1.

The payoff matrix of an example game called *Rock-Paper-Scissors* looks like this.

|          | Rock | Paper | Scissors |
| :------- | :--: | :---: | :------: |
| Rock     |    0 |    -1 |        1 |
| Paper    |    1 |     0 |       -1 |
| Scissors |   -1 |     1 |        0 |

As we know from real world playing, the optimal strategy for both players is to choose each action with equal probability `1/3`.

Compare this result to the result provided by the algorithms in the package.

## Table of contents for easy navigation
```@contents
```
