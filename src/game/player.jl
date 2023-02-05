"""
    Player

Represent a Player with an integer `id` in a Game

# Examples
```jldoctest
julia> Player(1)
Player 1

julia> Player(2)
Player 2
```
"""
struct Player
    id::Integer
end

Base.show(io::IO, p::Player) = print(io, "Player $(p.id)")

"""
    createplayers(n::Integer)

Create a vector of ``n`` Players with ids ``i ∈ \{1,…,n\}``

# Examples
```jldoctest
julia> createplayers(3)
3-element Vector{Player}:
 Player 1
 Player 2
 Player 3

```
"""
createplayers(n::Integer) = [Player(i) for i in 1:n]

"""
    getindex(container::AbstractVecOrTuple, player::Player)

Get the element on index of a `player` inside the `container`.
The container has to be either Vector or Tuple
The index corresponds to `id` of the `player`.

# Examples
```jldoctest
julia> names = ("John", "Thomas", "Agatha")
("John", "Thomas", "Agatha")

julia> names[Player(3)]
"Agatha"

```
"""
Base.getindex(container::Base.AbstractVecOrTuple, player::Player) = 1 <= player.id <= length(container) ? container[player.id] : nothing
