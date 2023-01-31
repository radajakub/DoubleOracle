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

"""
    load(filepath, type)

Load and return a game of `type` (i.e. ``NormalFormGame``, ...) from file located in the filesystem at `filepath`.
The extension of the `filepath` must correspond to the game `type` (e.g. ``NormalFormGame -> .nfg``).

# EXample
```
julia> nf = load("./data/nf_games/mathing_pennies.nfg, NormalFormGame)
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
