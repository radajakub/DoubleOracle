"""
    Game

Abstract type uniting all types of games in Game Theory.
"""
abstract type Game end

"""
    NormalFormGame{T}

Model for a two-player zero-sum game in Normal Form.
Here, player 1 tries to maximise the outcome of type `T`, player 2 minimises it.

# Fields
- `name`: Name of the NF game
-    `N`: Players of the game
-    `A`: Available actions of each player
-    `U`: Game matrix containing the outcomes for each joint action profile
"""
struct NormalFormGame{T} <: Game where {T<:Real}
    name::String
    N::NTuple{2,Player}
    A::NTuple{2,ActionSet}
    U::Matrix{T}
end

function Base.show(io::IO, nfg::NormalFormGame)
    println(io, "===== $(nfg.name) =====")
    println(io, "players: ", join(nfg.N, " | "))
    println(io)
    for p in nfg.N
        println(io, nfg.A[p])
    end
    println(io)

    # print utility table dimensions
    A1, A2 = nfg.A
    println(io, "U ($(A1.n) × $(A2.n))")

    # convert values to strings
    Ustring = string.(nfg.U)

    # compute cell max widths
    cellwidth = max(maximum(length, Ustring), maximum(length, allnames(A2)))
    tabwidth = maximum(length, allnames(A1)) + 1

    # compute helper strings
    tab = " "^tabwidth
    hrule = "-"^((cellwidth + 3) * A2.n + 1)

    # print utility table header
    println(io, tab, " ", join(map(id -> " $(lpad(A2[id], cellwidth))  ", A2)))
    println(io, tab, " ", hrule)

    # print utility table content
    for a1 in A1.ids
        println(io, lpad(A1[a1], tabwidth), " |", join(map(a2 -> " $(lpad(nfg[a1, a2], cellwidth)) |", A2)))
        println(io, tab, " ", hrule)
    end
end

"""
    getindex(nfg::NormalFormGame, a1::Integer, a2::Integer)

Obtain `nfg` outcome by playing joing action profile `(a1, a2)`
# Example
```jldoctest
julia> nfg = load("./data/nf_games/mathing_pennies.nfg, NormalFormGame);
julia> nfg[1, 1]
1

julia> nfg["1", "B"]
-1

```
"""
Base.getindex(nfg::NormalFormGame, a1::Integer, a2::Integer) = nfg.U[a1, a2]
function Base.getindex(nfg::NormalFormGame, a1::String, a2::String)
    A1, A2 = nfg.A
    return nfg.U[A1[a1], A2[a2]]
end

"""
    load(filepath::String, type::Type{NormalFormGame})

Load and return a game of `type` (i.e. ``NormalFormGame``, ...) from file located in the filesystem at `filepath`.
The extension of the `filepath` must correspond to the game `type` (e.g. ``NormalFormGame -> .nfg``).

# EXample
```
julia> nfg = load("./data/nf_games/mathing_pennies.nfg, NormalFormGame)
```
"""
function load(filepath::String, ::Type{NormalFormGame})
    (isfile(filepath) && endswith(filepath, ".nfg")) || throw(ErrorException("File does not exist or is of wrong type"))

    P1, P2 = createplayers(2)

    A1 = nothing
    A2 = nothing
    U = nothing

    open(filepath, "r") do io
        # iterate eachline of file named filpath
        for line in eachline(io)
            # if actions were loaded but the value matrix was not yet allocated
            if isnothing(U) && !isnothing(A1) && !isnothing(A2)
                U = zeros(Float64, length(A1), length(A2))
            end

            # split line into leading command specifing information type and the rest
            command, content = string.(strip.(split(line, ":")))
            content = string.(split(content, " "))

            # choose action based on datatype
            if command == "actions1"
                A1 = ActionSet(P1, content)
            elseif command == "actions2"
                A2 = ActionSet(P2, content)
            elseif command == "U" && !isnothing(A1) && !isnothing(A2) && length(content) == 3
                U[A1[content[1]], A2[content[2]]] = parse(Float64, content[3])
            end
        end
    end

    # construct the game
    return NormalFormGame(basename(filepath), (P1, P2), (A1, A2), U)
end
