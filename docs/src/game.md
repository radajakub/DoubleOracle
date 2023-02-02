# Game

This parts documents loading and generating a new game and auxiliary functions for this process.

## Player

Structure and functions representing Players in the game.
`Player` is used mainly for printing and for indexing in more complicated structures.

One or more `Players` can be created at once.
```@docs
Player
createplayers(::Integer)
```

As said above, a `Player` structure can be used to easier indexing without the need of remembering ids.
```@docs
Base.getindex(::Base.AbstractVecOrTuple, ::Player)
```

## ActionSet

Structure that provides an abstraction over a set of available actions of a single player.
It gives easy translations between `names` given by user in the input file and `ids` that are used as indices to strategy vectors and utility matrix.

```@docs
ActionSet
ActionSet(::Player, ::Vector{String})
```

Some standard container functions are overloaded to make indexing and iteration simpler.

```@docs
Base.getindex(::ActionSet, ::Integer)
Base.getindex(::ActionSet, ::String)
Base.length(::ActionSet)
Base.iterate(::ActionSet)
```

To obtain `::Vector{String}` of names of all actions in the set in the exact order as the ids, use the `allnames` function.

```@docs
allnames(::ActionSet)
```

Another often used feature is selecting a single action at random from the set.
This can be done by

```@docs
randomaction(::ActionSet)
```

## Game

```@docs
Game
```

First used game is the well-known Normal-Form game represented as an utility matrix.
We focus on two-player zero-sum NF games.

```@docs
NormalFormGame
```

There are two possible ways how to create a `NormalFormGame` structure.
First is loading a prepared game from a text file ending with `.nfg` and following a format given by examples in `/data/` folder.
Second is setting some parameters and constraints to generate a random game.

```@docs
load(::String, ::Type{NormalFormGame})
generate(::Type{NormalFormGame};)
```

To avoid always writing `nfg.U[a1, a2]` a shortcut is provided.
```@docs
Base.getindex(::NormalFormGame, ::Integer, ::Integer)
```
