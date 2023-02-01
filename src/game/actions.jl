"""
    ActionSet

Set of actions of a single player. Store names and assign ids for internal representation.

# Fields
- `player`: Player owning the set of actions
- `n`: Number of actions in the set
- `ids`: Vector of assigned integer ids
- `idtoname`: Map translating an integer id to an action name
- `nametoid`: Map translating name of action to the assigned id
"""
struct ActionSet
    player::Player
    n::Integer
    ids::Vector{Integer}
    idtoname::Dict{Integer,String}
    nametoid::Dict{String,Integer}
end

Base.show(io::IO, A::ActionSet) = print(io, "Actions of $(A.player):", join(map(id -> " [$id] $(A[id]) |", A.ids)))

"""
    ActionSet(player::Player, actionnames::Vector{String})

Construct ActionSet for `player` containing action with names as in `actionnames`.

# Examples
```jldoctest
julia> ActionSet(Player(1), ["A", "B", "C"])
Actions of Player 1: [1] A | [2] B | [3] C |

julia> ActionSet(Player(2), ["f", "e", "d"])
Actions of Player 2: [1] f | [2] e | [3] d |

```
"""
function ActionSet(player::Player, actionnames::Vector{String})
    idtoname = Dict{Integer,String}()
    nametoid = Dict{String,Integer}()
    for (i, name) in enumerate(actionnames)
        idtoname[i] = name
        nametoid[name] = i
    end
    n = length(actionnames)
    return ActionSet(player, n, collect(1:n), idtoname, nametoid)
end

"""
    getindex(A::ActionSet, id::Integer)

Retrieve name of action with assigned `id`.

# Examples
```jldoctest
julia> A = ActionSet(Player(1), ["A", "B", "C", "D"])
Actions of Player 1: [1] A | [2] B | [3] C | [4] D |

julia> A[3]
"C"

```
"""
Base.getindex(A::ActionSet, id::Integer) = A.idtoname[id]

"""
    getindex(A::ActionSet, name::String)

Retrieve id of action named `name`.

# Examples
```jldoctest
julia> A = ActionSet(Player(1), ["A", "B", "C", "D"])
Actions of Player 1: [1] A | [2] B | [3] C | [4] D |

julia> A["B"]
2

```
"""
Base.getindex(A::ActionSet, name::String) = A.nametoid[name]

"""
    length(A::ActionSet)

Return number of actions in `A`.

# Examples
```jldoctest
julia> A = ActionSet(Player(1), ["A", "B", "C", "D"])
Actions of Player 1: [1] A | [2] B | [3] C | [4] D |

julia> length(A)
4

```
"""
Base.length(A::ActionSet) = A.n

"""
    iterate(A::ActionSet)

Go through ids of all actions in fixed order.

# Examples
```jldoctest
julia> A = ActionSet(Player(1), ["A", "B", "C", "D"])
Actions of Player 1: [1] A | [2] B | [3] C | [4] D |

julia> collect(A)
4-element Vector{Any}:
 1
 2
 3
 4

```
"""
Base.iterate(A::ActionSet, state=1) = state > A.n ? nothing : (A.ids[state], state + 1)

"""
    allnames(A::ActionSet)

Return list of action `names` from `A` in the same order as `ids`

# Examples
```jldoctest
julia> A = ActionSet(Player(1), ["A", "B", "C", "D"])
Actions of Player 1: [1] A | [2] B | [3] C | [4] D |

julia> allnames(A)
4-element Vector{String}:
 "A"
 "B"
 "C"
 "D"

```
"""
allnames(A::ActionSet) = map(id -> A[id], A.ids)
