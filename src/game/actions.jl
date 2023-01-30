"""
    ActionSet

Set of actions of a single player. Stores names and assigns ids for internal representation.
"""
struct ActionSet
    "Player owning the set of actions"
    player::Player
    "Number of actions in the set"
    n::Integer
    "Vector of assigned integer ids"
    ids::Vector{Integer}
    "Map translating an integer id to an action name"
    idtoname::Dict{Integer,String}
    "Map translating name of action to the assigned id"
    nametoid::Dict{String,Integer}
end

"""
    ActionSet(player, actionnames)

Construct ActionSet for `player` containing action with names as in `actionnames`.

# Examples
```jldoctest
julia> ActionSet(Player(1), ["A", "B", "C"])
Actions of Player 1
→ [1] A
→ [2] B
→ [3] C

julia> ActionSet(Player(2), ["f", "e", "d"])
Actions of Player 2
→ [1] f
→ [2] e
→ [3] d
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
    getindex(A, id::Integer)

Retrieve name of action with assigned `id`.

# Examples
```jldoctest
julia> A[3]
"C"
```
"""
Base.getindex(A::ActionSet, id::Integer) = A.idtoname[id]

"""
    getindex(A, name::String)

Retrieve id of action named `name`.

# Examples
```jldoctest
julia> A["C"]
3
```
"""
Base.getindex(A::ActionSet, name::String) = A.nametoid[name]

"""
    length(A)

Return number of actions in `A`.

# Examples
```jldoctest
julia> length(A)
3
```
"""
Base.length(A::ActionSet) = A.n

"""
    iterate(A)

Go through ids of all actions in fixed order.

# Examples
```jldoctest
julia> collect(A)
3-element Vector{Any}:
 1
 2
 3
```
"""
Base.iterate(A::ActionSet, state=1) = state > A.n ? nothing : (A.ids[state], state + 1)

function Base.show(io::IO, A::ActionSet)
    print(io, "Actions of $(A.player)")
    for id in A.ids
        println(io)
        print(io, "→ [$id] $(A[id])")
    end
end
