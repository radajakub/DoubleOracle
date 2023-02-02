"""
    Oracle

Keep strategies already present in the restricted Normal-Form game.
Changes occur between iterations and thus represents (partial) state of the Double Oracle algorithm.

# Fields
- `player`: owner of the oracle
- `selected`: vector of action ids of a given player which are present in the restricted game
"""
struct Oracle
    player::Player
    selected::Vector{Integer}

    Oracle(player::Player, initaction::Integer) = new(player, [initaction])
end

function Base.show(io::IO, O::Oracle)
    print(io, "Oracle for $(O.player) has actions: [$(join(map(string, O.selected), ", "))]")
end

"""
    Base.length(O::Oracle)

Return number of actions in the oracle `O`.

# Examples
```jldoctest
julia> O = Oracle(Player(2), 3)
Oracle for Player 2 has actions: [3]

julia> length(O)
1
```
"""
Base.length(O::Oracle) = length(O.selected)

"""
    Base.iterate(O::Oracle)

Provide a way to iterate over selected actions in the Oracle `O`.

# Examples
```
julia> O = Oracle(Player(2), 1);

julia> add!(O, 2);

julia> add!(O, 4);

julia> collect(O)
3-element Vector{Any}:
 1
 2
 4

```
"""
Base.iterate(O::Oracle, state=1) = state > length(O) ? nothing : (O.selected[state], state + 1)

"""
    add!(O::Oracle, actionid::Integer)

Add a new `actionid` of an action into the selected actions in Oracle `O`.

# Examples
```jldoctest
julia> O = Oracle(Player(2), 1)
Oracle for Player 2 has actions: [1]

julia> add!(O, 2);

julia> O
Oracle for Player 2 has actions: [1, 2]

```
"""
function add!(O::Oracle, actionid::Integer)
    if !(actionid in O)
        push!(O.selected, actionid)
        sort!(O.selected)
    end
end

"""
    fullstrategy(O::Oracle, p::Vector{Float64}, n::Integer)

Creates a new strategy of length `n`. The probabilities of actions in the Oracle `O` are replaced with values from restricted strategy `p` (of the length `n`). Rest of the probabilities are set to 0.0.

# Examples
```jldoctest
julia> O = Oracle(Player(1), 1);

julia> add!(O, 3);

julia> O
Oracle for Player 1 has actions: [1, 3]

julia> p = [0.3, 0.7];

julia> fullstrategy(O, p, 4)
4-element Vector{Float64}:
 0.3
 0.0
 0.7
 0.0

```
"""
function fullstrategy(O::Oracle, p::Vector{Float64}, n::Integer)
    fullp = zeros(Float64, n)
    fullp[O.selected] = p
    return fullp
end
