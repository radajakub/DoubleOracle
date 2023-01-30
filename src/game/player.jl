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
    createplayers(n)

Create a vector of ``n`` Players with ids ``i ∈ {1,…,n}``
"""
createplayers(n::Integer) = [Player(i) for i in 1:n]
