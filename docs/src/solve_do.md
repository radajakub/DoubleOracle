# Solution by Double Oracle algorithm

This section discusses solution of a two-player zero-sum Normal-Form game by using the Double Oracle algorithm.

```@docs
DoubleOracleAlgorithm
```

First, we describe some necessary structures and functions which enable us solving the game.

## Oracle

First and most important concept for this solution mechanism is an *Oracle*.
It tells which actions are likely to be a support of the equilibrium mixed strategy.

```@docs
Oracle
Base.length(::Oracle)
Base.iterate(::Oracle)
```

To add another action `id` to the Oracle, the prepared modifier function can be used.

```@docs
add!(::Oracle, ::Integer)
```

## Game restrictions

The Double Oracle algorithm always operates over some subgame to reduce computation time.
These subgames are defined by one or both oracles and are different in each situation.

```@docs
GameRestriction
ColumnRestriction
RowRestriction
```

These restrictions are then created from the full payoff matrix of the original `nfg` game and created Oracles.
The type of restriction is given by the above mentioned restriction types.

```@docs
restrict(::NormalFormGame, ::Oracle, ::Oracle)
restrict(::NormalFormGame, ::Oracle, ::Type{ColumnRestriction})
restrict(::NormalFormGame, ::Oracle, ::Type{RowRestriction})
```

## Best response

Last necessary component of the Double Oracle algorithm is a concept of a best response.
Here, the players search for an optimal pure strategy (i.e. single action), which would result in the best payoff (from their perspective) while keeping the Oracle and strategy of the opponent fixed.

```@docs
bestresponse(::NormalFormGame, ::Oracle, ::Vector{Float64}, ::Type{ColumnRestriction})
bestresponse(::NormalFormGame, ::Oracle, ::Vector{Float64}, ::Type{RowRestriction})
```

Now, all the components for the complete Double Oracle algorithm are prepared.

## Double Oracle algorithm

This algorithm is more suitable for games with large number of actions, where it is not expected that the support of an equilibrium strategy is not expected to be very large.
On such games, it should outperform the standard Linear programming method.

```@docs
solve(::NormalFormGame, ::Type{DoubleOracleAlgorithm})
```

Note that the double oracle algorithm does not necessarily compute the whole strategy, but only a part corresponding to the restricted payoff matrix.
To fix this issue, the following function is used to finalize the output.

```@docs
fullstrategy(::Oracle, ::Vector{Float64}, n::Integer)
```
