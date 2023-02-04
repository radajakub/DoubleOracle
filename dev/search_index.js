var documenterSearchIndex = {"docs":
[{"location":"benchmarks/#Benchmarks","page":"Benchmarks","title":"Benchmarks","text":"","category":"section"},{"location":"game/#Game","page":"Game definition","title":"Game","text":"","category":"section"},{"location":"game/","page":"Game definition","title":"Game definition","text":"This parts documents loading and generating a new game and auxiliary functions for this process.","category":"page"},{"location":"game/#Player","page":"Game definition","title":"Player","text":"","category":"section"},{"location":"game/","page":"Game definition","title":"Game definition","text":"Structure and functions representing Players in the game. Player is used mainly for printing and for indexing in more complicated structures.","category":"page"},{"location":"game/","page":"Game definition","title":"Game definition","text":"One or more Players can be created at once.","category":"page"},{"location":"game/","page":"Game definition","title":"Game definition","text":"Player\ncreateplayers(::Integer)","category":"page"},{"location":"game/#DoubleOracle.Player","page":"Game definition","title":"DoubleOracle.Player","text":"Player\n\nRepresent a Player with an integer id in a Game\n\nExamples\n\njulia> Player(1)\nPlayer 1\n\njulia> Player(2)\nPlayer 2\n\n\n\n\n\n","category":"type"},{"location":"game/#DoubleOracle.createplayers-Tuple{Integer}","page":"Game definition","title":"DoubleOracle.createplayers","text":"createplayers(n::Integer)\n\nCreate a vector of n Players with ids i  1n\n\nExamples\n\njulia> createplayers(3)\n3-element Vector{Player}:\n Player 1\n Player 2\n Player 3\n\n\n\n\n\n\n","category":"method"},{"location":"game/","page":"Game definition","title":"Game definition","text":"As said above, a Player structure can be used to easier indexing without the need of remembering ids.","category":"page"},{"location":"game/","page":"Game definition","title":"Game definition","text":"Base.getindex(::Base.AbstractVecOrTuple, ::Player)","category":"page"},{"location":"game/#Base.getindex-Tuple{Union{Tuple{Vararg{T}}, AbstractVector{<:T}} where T, Player}","page":"Game definition","title":"Base.getindex","text":"getindex(container::AbstractVecOrTuple, player::Player)\n\nGet the element on index of a player inside the container. The container has to be either Vector or Tuple The index corresponds to id of the player.\n\nExamples\n\njulia> names = (\"John\", \"Thomas\", \"Agatha\")\n(\"John\", \"Thomas\", \"Agatha\")\n\njulia> names[Player(3)]\n\"Agatha\"\n\n\n\n\n\n\n","category":"method"},{"location":"game/#ActionSet","page":"Game definition","title":"ActionSet","text":"","category":"section"},{"location":"game/","page":"Game definition","title":"Game definition","text":"Structure that provides an abstraction over a set of available actions of a single player. It gives easy translations between names given by user in the input file and ids that are used as indices to strategy vectors and utility matrix.","category":"page"},{"location":"game/","page":"Game definition","title":"Game definition","text":"ActionSet\nActionSet(::Player, ::Vector{String})","category":"page"},{"location":"game/#DoubleOracle.ActionSet","page":"Game definition","title":"DoubleOracle.ActionSet","text":"ActionSet\n\nSet of actions of a single player. Store names and assign ids for internal representation.\n\nFields\n\nplayer: Player owning the set of actions\nn: Number of actions in the set\nids: Vector of assigned integer ids\nidtoname: Map translating an integer id to an action name\nnametoid: Map translating name of action to the assigned id\n\n\n\n\n\n","category":"type"},{"location":"game/#DoubleOracle.ActionSet-Tuple{Player, Vector{String}}","page":"Game definition","title":"DoubleOracle.ActionSet","text":"ActionSet(player::Player, actionnames::Vector{String})\n\nConstruct ActionSet for player containing action with names as in actionnames.\n\nExamples\n\njulia> ActionSet(Player(1), [\"A\", \"B\", \"C\"])\nActions of Player 1: [1] A | [2] B | [3] C |\n\njulia> ActionSet(Player(2), [\"f\", \"e\", \"d\"])\nActions of Player 2: [1] f | [2] e | [3] d |\n\n\n\n\n\n\n","category":"method"},{"location":"game/","page":"Game definition","title":"Game definition","text":"Some standard container functions are overloaded to make indexing and iteration simpler.","category":"page"},{"location":"game/","page":"Game definition","title":"Game definition","text":"Base.getindex(::ActionSet, ::Integer)\nBase.getindex(::ActionSet, ::String)\nBase.length(::ActionSet)\nBase.iterate(::ActionSet)","category":"page"},{"location":"game/#Base.getindex-Tuple{ActionSet, Integer}","page":"Game definition","title":"Base.getindex","text":"getindex(A::ActionSet, id::Integer)\n\nRetrieve name of action with assigned id.\n\nExamples\n\njulia> A = ActionSet(Player(1), [\"A\", \"B\", \"C\", \"D\"])\nActions of Player 1: [1] A | [2] B | [3] C | [4] D |\n\njulia> A[3]\n\"C\"\n\n\n\n\n\n\n","category":"method"},{"location":"game/#Base.getindex-Tuple{ActionSet, String}","page":"Game definition","title":"Base.getindex","text":"getindex(A::ActionSet, name::String)\n\nRetrieve id of action named name.\n\nExamples\n\njulia> A = ActionSet(Player(1), [\"A\", \"B\", \"C\", \"D\"])\nActions of Player 1: [1] A | [2] B | [3] C | [4] D |\n\njulia> A[\"B\"]\n2\n\n\n\n\n\n\n","category":"method"},{"location":"game/#Base.length-Tuple{ActionSet}","page":"Game definition","title":"Base.length","text":"length(A::ActionSet)\n\nReturn number of actions in A.\n\nExamples\n\njulia> A = ActionSet(Player(1), [\"A\", \"B\", \"C\", \"D\"])\nActions of Player 1: [1] A | [2] B | [3] C | [4] D |\n\njulia> length(A)\n4\n\n\n\n\n\n\n","category":"method"},{"location":"game/#Base.iterate-Tuple{ActionSet}","page":"Game definition","title":"Base.iterate","text":"iterate(A::ActionSet)\n\nGo through ids of all actions in fixed order.\n\nExamples\n\njulia> A = ActionSet(Player(1), [\"A\", \"B\", \"C\", \"D\"])\nActions of Player 1: [1] A | [2] B | [3] C | [4] D |\n\njulia> collect(A)\n4-element Vector{Any}:\n 1\n 2\n 3\n 4\n\n\n\n\n\n\n","category":"method"},{"location":"game/","page":"Game definition","title":"Game definition","text":"To obtain ::Vector{String} of names of all actions in the set in the exact order as the ids, use the allnames function.","category":"page"},{"location":"game/","page":"Game definition","title":"Game definition","text":"allnames(::ActionSet)","category":"page"},{"location":"game/#DoubleOracle.allnames-Tuple{ActionSet}","page":"Game definition","title":"DoubleOracle.allnames","text":"allnames(A::ActionSet)\n\nReturn list of action names from A in the same order as ids\n\nExamples\n\njulia> A = ActionSet(Player(1), [\"A\", \"B\", \"C\", \"D\"])\nActions of Player 1: [1] A | [2] B | [3] C | [4] D |\n\njulia> allnames(A)\n4-element Vector{String}:\n \"A\"\n \"B\"\n \"C\"\n \"D\"\n\n\n\n\n\n\n","category":"method"},{"location":"game/","page":"Game definition","title":"Game definition","text":"Another often used feature is selecting a single action at random from the set. This can be done by","category":"page"},{"location":"game/","page":"Game definition","title":"Game definition","text":"randomaction(::ActionSet)","category":"page"},{"location":"game/#DoubleOracle.randomaction-Tuple{ActionSet}","page":"Game definition","title":"DoubleOracle.randomaction","text":"randomaction(A::ActionSet)\n\nSelect a random action id of the action set A.\n\nExamples\n\njulia> A = ActionSet(Player(1), [\"A\", \"B\", \"C\", \"D\"]);\n\njulia> a = randomaction(A)\na = 3\n\n\n\n\n\n","category":"method"},{"location":"game/#Game-2","page":"Game definition","title":"Game","text":"","category":"section"},{"location":"game/","page":"Game definition","title":"Game definition","text":"Game","category":"page"},{"location":"game/#DoubleOracle.Game","page":"Game definition","title":"DoubleOracle.Game","text":"Game\n\nAbstract type uniting all types of games in Game Theory.\n\n\n\n\n\n","category":"type"},{"location":"game/","page":"Game definition","title":"Game definition","text":"First used game is the well-known Normal-Form game represented as an utility matrix. We focus on two-player zero-sum NF games.","category":"page"},{"location":"game/","page":"Game definition","title":"Game definition","text":"NormalFormGame","category":"page"},{"location":"game/#DoubleOracle.NormalFormGame","page":"Game definition","title":"DoubleOracle.NormalFormGame","text":"NormalFormGame{T}\n\nModel for a two-player zero-sum game in Normal Form. Here, player 1 tries to maximise the outcome of type T, player 2 minimises it.\n\nFields\n\nname: Name of the NF game\nN: Players of the game\nA: Available actions of each player\nU: Game matrix containing the outcomes for each joint action profile\n\n\n\n\n\n","category":"type"},{"location":"game/","page":"Game definition","title":"Game definition","text":"There are two possible ways how to create a NormalFormGame structure. First is loading a prepared game from a text file ending with .nfg and following a format given by examples in /data/ folder. Second is setting some parameters and constraints to generate a random game.","category":"page"},{"location":"game/","page":"Game definition","title":"Game definition","text":"load(::String, ::Type{NormalFormGame})\ngenerate(::Type{NormalFormGame};)","category":"page"},{"location":"game/#DoubleOracle.load-Tuple{String, Type{NormalFormGame}}","page":"Game definition","title":"DoubleOracle.load","text":"load(filepath::String, type::Type{NormalFormGame})\n\nLoad and return a game of type (i.e. NormalFormGame, ...) from file located in the filesystem at filepath. The extension of the filepath must correspond to the game type (e.g. NormalFormGame - nfg).\n\nExample\n\njulia> nfg = load(\"../data/nf_games/mathing_pennies.nfg\", NormalFormGame)\n\n\n\n\n\n","category":"method"},{"location":"game/#DoubleOracle.generate-Tuple{Type{NormalFormGame}}","page":"Game definition","title":"DoubleOracle.generate","text":"generate(::Type{NormalFormGame}, A1min, A1max, A2min, A2max, minutil, maxutil, utilstep)\n\nGenerate random Normal-Form game with given parameters.\n\nFields\n\nA1min::Integer: minimum number of actions of player 1 (default 2)\nA1max::Integer: maximum number of actions of player 1 (default 5)\nA2min::Integer: minimum number of actions of player 2 (default 2)\nA2max::Integer: maximum number of actions of player 2 (default 5)\nminutil<:Real: minimum utility possible for player 1\nmaxutil<:Real: maxium utility possible for player 1\nutilstep<:Real: minimum difference between two different utility values for player 1\nunique: option to enforce unique payoffs from the interval minutil:maxutil (ignores step to produce sufficient range)\n\nExamples\n\njulia> generate(NormalFormGame; A1min=2, A1max=2, A2min=3, A2max=3, minutil=1, maxutil=1)\n===== generated =====\nplayers: Player 1 | Player 2\n\nActions of Player 1: [1] 1 | [2] 2 |\nActions of Player 2: [1] 1 | [2] 2 | [3] 3 |\n\nU (2 × 3)\n    1   2   3\n   -------------\n 1 | 1 | 1 | 1 |\n   -------------\n 2 | 1 | 1 | 1 |\n   -------------\n\n\n\n\n\n","category":"method"},{"location":"game/","page":"Game definition","title":"Game definition","text":"To avoid always writing nfg.U[a1, a2] a shortcut is provided.","category":"page"},{"location":"game/","page":"Game definition","title":"Game definition","text":"Base.getindex(::NormalFormGame, ::Integer, ::Integer)","category":"page"},{"location":"game/#Base.getindex-Tuple{NormalFormGame, Integer, Integer}","page":"Game definition","title":"Base.getindex","text":"getindex(nfg::NormalFormGame, a1::Integer, a2::Integer)\n\nObtain nfg outcome by playing joing action profile (a1, a2)\n\nExamples\n\njulia> nfg = load(\"../data/nf_games/matching_pennies.nfg\", NormalFormGame);\n\njulia> nfg[1, 1]\n1.0\n\njulia> nfg[\"1\", \"B\"]\n-1.0\n\n\n\n\n\n\n","category":"method"},{"location":"solution_utils/#Solution-utilities","page":"Solution utilities","title":"Solution utilities","text":"","category":"section"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"This part summarizes funtions and structures providing solutions for games defined in previous section.","category":"page"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"Algorithm","category":"page"},{"location":"solution_utils/#DoubleOracle.Algorithm","page":"Solution utilities","title":"DoubleOracle.Algorithm","text":"Algorithm\n\nAbstract type representing solving algorithms of a game in the Game Theory\n\n\n\n\n\n","category":"type"},{"location":"solution_utils/#Matrix-Game","page":"Solution utilities","title":"Matrix Game","text":"","category":"section"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"This serves as a general solver for matrix game with arbitrary size, not necessarily corresponding to size of the actual Normal-Form game. It solves a linear program for the passed matrix u (game or subgame) and saves the outcomes and equilibrium strategies of both players.","category":"page"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"MatrixGame","category":"page"},{"location":"solution_utils/#DoubleOracle.MatrixGame","page":"Solution utilities","title":"DoubleOracle.MatrixGame","text":"MatrixGame\n\nSolve and represent solution of a Matrix game with matrix u. Solution is made by a standard linear program for two-player zero-sum Normal-form games. Both outcome and an equilibrium strategy is saved for both players. Note that this can be only a solution of a subgame, not necessarily the whole NFG.\n\nFields\n\noutcomes: 2-tuple with game outcomes for each respective player\nstrategies: 2-tuple with en equilibrium strategies (probability distribution over rows/columns Δ(A)) for each respective player\n\nExamples\n\njulia> u = [1 -1; -1 1];\n\njulia> MatrixGame(u)\nMatrixGame results:\n→ outcome of the Nash Equilibrium: (0.0, -0.0)\n→ strategy of row player: [0.5, 0.5]\n→ strategy of column player: [0.5, 0.5]\n\n\n\n\n\n\n","category":"type"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"Again, for easier extraction of results, indexing shortcuts are provided.","category":"page"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"(:MatrixGame)(::Player)\nBase.getindex(::MatrixGame, ::Player)","category":"page"},{"location":"solution_utils/#DoubleOracle.MatrixGame-Tuple{Player}","page":"Solution utilities","title":"DoubleOracle.MatrixGame","text":"(mg::MatrixGame)(p::Player)\n\nObtain the outcome value of a player from the MatrixGame structure.\n\nExamples\n\njulia> mg = MatrixGame([1 -1; -1 1]);\n\njulia> mg(Player(1))\n0.0\n\n\n\n\n\n\n","category":"method"},{"location":"solution_utils/#Base.getindex-Tuple{MatrixGame, Player}","page":"Solution utilities","title":"Base.getindex","text":"getindex(mg::MatrixGame, p::Player)\n\nObtain the strategy of a player from the MatrixGame structure.\n\nExamples\n\njulia> mg = MatrixGame([1 -1; -1 1]);\n\njulia> mg[Player(1)]\n2-element Vector{Float64}:\n 0.5\n 0.5\n\n\n\n\n\n\n","category":"method"},{"location":"solution_utils/#Solution","page":"Solution utilities","title":"Solution","text":"","category":"section"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"Solution represents the final solution of the whole Normal-Form game. It holds final equilibria strategies and outcomes.","category":"page"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"Solution\nSolution(::MatrixGame, ::NormalFormGame, ::Type{<:Algorithm})","category":"page"},{"location":"solution_utils/#DoubleOracle.Solution","page":"Solution utilities","title":"DoubleOracle.Solution","text":"Solution\n\nRepresent solution of the Normal-Form game. In contrast to MatrixGame, this solution corresponds always to the whole NFG.\n\nFields\n\nname: name of the NormalFormGame (for pretty output)\nmethod: name of the method used to solve the problem\noutcomes: 2-tuple of outcome for each player\nstrategies: 2-tuple of strategies for each player (strategy is a vector of tuples, where first part is name of action and second is a playing probability in equilibrium)\n\n\n\n\n\n","category":"type"},{"location":"solution_utils/#DoubleOracle.Solution-Tuple{MatrixGame, NormalFormGame, Type{<:Algorithm}}","page":"Solution utilities","title":"DoubleOracle.Solution","text":"Solution(mg::MatrixGame, nfg::NormalFormGame, method::Type{<:Algorithm})\n\nConstruct Solution in a case where mg contains solution of the whole nfg, i.e. in exact solution by linear programming. Strategies in mg are assumed to be of same length as action sets in nfg.\n\nExamples\n\njulia> nfg = load(\"../data/nf_games/matching_pennies.nfg\", NormalFormGame);\n\njulia> mg = MatrixGame(nfg.U);\n\njulia> Solution(mg, nfg, LinearProgram)\nThe two-player zero-sum Normal-Form game was solved by Linear program\nPlayer 1 gains outcome 0.0 by playing a strategy\n → [1 : 0.5, 2 : 0.5]\nPlayer 2 gains outcome -0.0 by playing a strategy\n → [A : 0.5, B : 0.5]\n\n\n\n\n\n\n","category":"method"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"As always, the shortcuts for easier indexing and uitilization of the Player abstraction.","category":"page"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"(:Solution)(::Player)\nBase.getindex(::Solution, ::Player)","category":"page"},{"location":"solution_utils/#DoubleOracle.Solution-Tuple{Player}","page":"Solution utilities","title":"DoubleOracle.Solution","text":"(solution::Solution)(p::Player)\n\nShortcut to obtain outcome of a player present in solution.\n\nExamples\n\njulia> solution = Solution(\"test\", LinearProgram, (1.0, -1.0), ([(\"A\", 1)], [(\"B\", 1)]));\n\njulia> solution(Player(2))\n-1.0\n\n\n\n\n\n\n","category":"method"},{"location":"solution_utils/#Base.getindex-Tuple{Solution, Player}","page":"Solution utilities","title":"Base.getindex","text":"getindex(solution::Solution, p::Player)\n\nShortcut to obtain strategy of a player present in solution.\n\nExamples\n\njulia> solution = Solution(\"test\", LinearProgram, (1.0, -1.0), ([(\"A\", 1)], [(\"B\", 1)]));\n\njulia> solution[Player(2)]\n1-element Vector{Tuple{String, Float64}}:\n (\"B\", 1.0)\n\n\n\n\n\n\n","category":"method"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"When probabilities are to be joined with corresponding action names, the pairstrategies function is advised to be used.","category":"page"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"pairstrategies(::Vector{String}, ::Vector{Float64})","category":"page"},{"location":"solution_utils/#DoubleOracle.pairstrategies-Tuple{Vector{String}, Vector{Float64}}","page":"Solution utilities","title":"DoubleOracle.pairstrategies","text":"pairstrategies(names::Vector{String}, probs::Vector{Float64})\n\nMerge names and probs (probabilities) in such a way that first element in names is joined with first element in probs into a tuple and so on.\n\nExamples\n\njulia> names = [\"A\", \"B\"];\n\njulia> probs = [1.0, 0.0];\n\njulia> pairstrategies(names, probs)\n2-element Vector{Tuple{String, Float64}}:\n (\"A\", 1.0)\n (\"B\", 0.0)\n\n\n\n\n\n\n","category":"method"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"To compare two solutions whether they are the same (or approximately the same with tolerance atol) use the following functions.","category":"page"},{"location":"solution_utils/","page":"Solution utilities","title":"Solution utilities","text":"samepayoffs(::NTuple{2,Float64}, ::NTuple{2,Float64})\nsamestrategies(::Vector{Tuple{String,Float64}}, ::Vector{Tuple{String,Float64}})\nsamesolutions(::Solution, ::Solution)","category":"page"},{"location":"solution_utils/#DoubleOracle.samepayoffs-Tuple{Tuple{Float64, Float64}, Tuple{Float64, Float64}}","page":"Solution utilities","title":"DoubleOracle.samepayoffs","text":"samepayoffs(s1::NTuple{2, Float64}, s2::NTuple{2, Float64}; atol=1e-4)\n\nCompare two solutions s1, s2 whether they have the same (or similar) payoffs. Outcomes are compared with tolerance atol.\n\nExamples\n\njulia> nfg = load(\"../data/nf_games/matching_pennies.nfg\", NormalFormGame);\n\njulia> s1 = solve(nfg, LinearProgram);\n\njulia> s2 = solve(nfg, DoubleOracleAlgorithm);\n\njulia> samepayoffs(s1.outcomes, s2.outcomes)\ntrue\n\n\n\n\n\n","category":"method"},{"location":"solution_utils/#DoubleOracle.samestrategies-Tuple{Vector{Tuple{String, Float64}}, Vector{Tuple{String, Float64}}}","page":"Solution utilities","title":"DoubleOracle.samestrategies","text":"samestrategies(s1::Vector{Tuple{String,Float64}}, s2::Vector{Tuple{String,Float64}}; atol=1e-4)\n\nCompare two vectors of strategies s1, s2 whether they are the same including name of actions and order. Probabilities in the strategies are compared with tolerance atol.\n\nExamples\n\njulia> s1 = [(\"A\", 0.2), (\"B\", 0.5), (\"C\", 0.3)];\n\njulia> s2 = [(\"A\", 0.20005), (\"B\", 0.49999), (\"C\", 0.3)];\n\njulia> s3 = [(\"A\", 0.3), (\"B\", 0.5), (\"D\", 0.2)];\n\njulia> samestrategies(s1, s2)\ntrue\n\njulia> samestrategies(s1, s3)\nfalse\n\n\n\n\n\n","category":"method"},{"location":"solution_utils/#DoubleOracle.samesolutions-Tuple{Solution, Solution}","page":"Solution utilities","title":"DoubleOracle.samesolutions","text":"samesolutions(s1::Solution, s2::Solution; atol=1e-4)\n\nCompare two solutions s1, s2 whether they are the same (or similar). Outcomes, names of actions and probabilities are compared with tolerance atol.\n\nExamples\n\njulia> nfg = load(\"../data/nf_games/matching_pennies.nfg\", NormalFormGame);\n\njulia> s1 = solve(nfg, LinearProgram);\n\njulia> s2 = solve(nfg, DoubleOracleAlgorithm);\n\njulia> samesolutions(s1, s2)\ntrue\n\n\n\n\n\n","category":"method"},{"location":"doc_index/#Index","page":"Index","title":"Index","text":"","category":"section"},{"location":"doc_index/","page":"Index","title":"Index","text":"","category":"page"},{"location":"solve_do/#Solution-by-Double-Oracle-algorithm","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"","category":"section"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"This section discusses solution of a two-player zero-sum Normal-Form game by using the Double Oracle algorithm.","category":"page"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"DoubleOracleAlgorithm","category":"page"},{"location":"solve_do/#DoubleOracle.DoubleOracleAlgorithm","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.DoubleOracleAlgorithm","text":"DoubleOracleAlgorithm\n\nSubtype of Algorithm representing solution of a Normal-Form game by the Double Oracle algorithm.\n\n\n\n\n\n","category":"type"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"First, we describe some necessary structures and functions which enable us solving the game.","category":"page"},{"location":"solve_do/#Oracle","page":"Solution by Double Oracle algorithm","title":"Oracle","text":"","category":"section"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"First and most important concept for this solution mechanism is an Oracle. It tells which actions are likely to be a support of the equilibrium mixed strategy.","category":"page"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"Oracle\nBase.length(::Oracle)\nBase.iterate(::Oracle)","category":"page"},{"location":"solve_do/#DoubleOracle.Oracle","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.Oracle","text":"Oracle\n\nKeep strategies already present in the restricted Normal-Form game. Changes occur between iterations and thus represents (partial) state of the Double Oracle algorithm.\n\nFields\n\nplayer: owner of the oracle\nselected: vector of action ids of a given player which are present in the restricted game\n\n\n\n\n\n","category":"type"},{"location":"solve_do/#Base.length-Tuple{Oracle}","page":"Solution by Double Oracle algorithm","title":"Base.length","text":"Base.length(O::Oracle)\n\nReturn number of actions in the oracle O.\n\nExamples\n\njulia> O = Oracle(Player(2), 3)\nOracle for Player 2 has actions: [3]\n\njulia> length(O)\n1\n\n\n\n\n\n","category":"method"},{"location":"solve_do/#Base.iterate-Tuple{Oracle}","page":"Solution by Double Oracle algorithm","title":"Base.iterate","text":"Base.iterate(O::Oracle)\n\nProvide a way to iterate over selected actions in the Oracle O.\n\nExamples\n\njulia> O = Oracle(Player(2), 1);\n\njulia> add!(O, 2);\n\njulia> add!(O, 4);\n\njulia> collect(O)\n3-element Vector{Any}:\n 1\n 2\n 4\n\n\n\n\n\n\n","category":"method"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"To add another action id to the Oracle, the prepared modifier function can be used.","category":"page"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"add!(::Oracle, ::Integer)","category":"page"},{"location":"solve_do/#DoubleOracle.add!-Tuple{Oracle, Integer}","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.add!","text":"add!(O::Oracle, actionid::Integer)\n\nAdd a new actionid of an action into the selected actions in Oracle O.\n\nExamples\n\njulia> O = Oracle(Player(2), 1)\nOracle for Player 2 has actions: [1]\n\njulia> add!(O, 2);\n\njulia> O\nOracle for Player 2 has actions: [1, 2]\n\n\n\n\n\n\n","category":"method"},{"location":"solve_do/#Game-restrictions","page":"Solution by Double Oracle algorithm","title":"Game restrictions","text":"","category":"section"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"The Double Oracle algorithm always operates over some subgame to reduce computation time. These subgames are defined by one or both oracles and are different in each situation.","category":"page"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"GameRestriction\nColumnRestriction\nRowRestriction","category":"page"},{"location":"solve_do/#DoubleOracle.GameRestriction","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.GameRestriction","text":"GameRestrictions\n\nAbstract type uniting possible partial restrictions of the game. Partial restriction means only some subset of rows or columns is preserved.\n\n\n\n\n\n","category":"type"},{"location":"solve_do/#DoubleOracle.ColumnRestriction","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.ColumnRestriction","text":"ColumnRestriction\n\nA game restriction which preserves only some columns from the payoff matrix. All rows in the given columns are preserved as well.\n\n\n\n\n\n","category":"type"},{"location":"solve_do/#DoubleOracle.RowRestriction","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.RowRestriction","text":"RowRestriction\n\nA game restriction which preserves only some rows from the payoff matrix. All columns in the given rows are preserved as well.\n\n\n\n\n\n","category":"type"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"These restrictions are then created from the full payoff matrix of the original nfg game and created Oracles. The type of restriction is given by the above mentioned restriction types.","category":"page"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"restrict(::NormalFormGame, ::Oracle, ::Oracle)\nrestrict(::NormalFormGame, ::Oracle, ::Type{ColumnRestriction})\nrestrict(::NormalFormGame, ::Oracle, ::Type{RowRestriction})","category":"page"},{"location":"solve_do/#DoubleOracle.restrict-Tuple{NormalFormGame, Oracle, Oracle}","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.restrict","text":"restrict(nfg::NormalFormGame, O1::Oracle, O2::Oracle)\n\nCreate a restriction of the payoff matrix of nfg, where only a subset of columns and a subset of rows is preserved. The preserved rows are given by actions in Oracle O1, the columns by Oracle O2.\n\nExamples\n\njulia> nfg = load(\"../data/nf_games/test.nfg\", NormalFormGame);\n\njulia> O1 = Oracle(Player(1), 1);\n\njulia> O2 = Oracle(Player(2), 2);\n\njulia> add!(O2, 3);\n\njulia> nfg.U\n2×3 Matrix{Float64}:\n  30.0  -10.0   20.0\n -10.0   20.0  -20.0\n\njulia> O1\nOracle for Player 1 has actions: [1]\n\njulia> O2\nOracle for Player 2 has actions: [2, 3]\n\njulia> restrict(nfg, O1, O2)\n1×2 Matrix{Float64}:\n -10.0  20.0\n\n\n\n\n\n\n","category":"method"},{"location":"solve_do/#DoubleOracle.restrict-Tuple{NormalFormGame, Oracle, Type{ColumnRestriction}}","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.restrict","text":"restrict(nfg::NormalFormGame, O::Oracle, ::Type{ColumnRestriction})\n\nCreate a restriction of the payoff matrix of nfg, where only a subset of columns is preserved. The preserved columns correspond to action ids given by Oracle O.\n\nExamples\n\njulia> nfg = load(\"../data/nf_games/test.nfg\", NormalFormGame);\n\njulia> O = Oracle(Player(2), 2);\n\njulia> add!(O, 3);\n\njulia> nfg.U\n2×3 Matrix{Float64}:\n  30.0  -10.0   20.0\n -10.0   20.0  -20.0\n\njulia> O\nOracle for Player 2 has actions: [2, 3]\n\njulia> restrict(nfg, O, ColumnRestriction)\n2×2 Matrix{Float64}:\n -10.0   20.0\n  20.0  -20.0\n\n\n\n\n\n","category":"method"},{"location":"solve_do/#DoubleOracle.restrict-Tuple{NormalFormGame, Oracle, Type{RowRestriction}}","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.restrict","text":"restrict(nfg::NormalFormGame, O::Oracle, ::Type{RowRestriction})\n\nCreate a restriction of the payoff matrix of nfg, where only a subset of columns is preserved. The preserved columns correspond to action ids given by Oracle O.\n\nExamples\n\njulia> nfg = load(\"../data/nf_games/test.nfg\", NormalFormGame);\n\njulia> O = Oracle(Player(1), 1);\n\njulia> nfg.U\n2×3 Matrix{Float64}:\n  30.0  -10.0   20.0\n -10.0   20.0  -20.0\n\njulia> O\nOracle for Player 1 has actions: [1]\n\njulia> restrict(nfg, O, RowRestriction)\n1×3 Matrix{Float64}:\n 30.0  -10.0  20.0\n\n\n\n\n\n\n","category":"method"},{"location":"solve_do/#Best-response","page":"Solution by Double Oracle algorithm","title":"Best response","text":"","category":"section"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"Last necessary component of the Double Oracle algorithm is a concept of a best response. Here, the players search for an optimal pure strategy (i.e. single action), which would result in the best outcome (from their perspective) while keeping the Oracle and strategy of the opponent fixed.","category":"page"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"bestresponse(::NormalFormGame, ::Oracle, ::Vector{Float64}, ::Type{ColumnRestriction})\nbestresponse(::NormalFormGame, ::Oracle, ::Vector{Float64}, ::Type{RowRestriction})","category":"page"},{"location":"solve_do/#DoubleOracle.bestresponse-Tuple{NormalFormGame, Oracle, Vector{Float64}, Type{ColumnRestriction}}","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.bestresponse","text":"bestresponse(nfg::NormalFormGame, O::Oracle, p::Vector{Float64}, ::Type{ColumnRestriction})\n\nFind id of a best response pure strategy in a Normal-Form game, when fixing Oracle O of the opponent and the equilibrium mixed strategy p, which is computed by solving a game restricted by Oracles of both players. This function finds the best response of the row player.\n\n\n\n\n\n","category":"method"},{"location":"solve_do/#DoubleOracle.bestresponse-Tuple{NormalFormGame, Oracle, Vector{Float64}, Type{RowRestriction}}","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.bestresponse","text":"bestresponse(nfg::NormalFormGame, O::Oracle, p::Vector{Float64}, ::Type{RowRestriction})\n\nFind id of a best response pure strategy in a Normal-Form game, when fixing Oracle O of the opponent and the equilibrium mixed strategy p, which is computed by solving a game restricted by Oracles of both players. This function finds the best response of the column player.\n\n\n\n\n\n","category":"method"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"Now, all the components for the complete Double Oracle algorithm are prepared.","category":"page"},{"location":"solve_do/#Double-Oracle-algorithm","page":"Solution by Double Oracle algorithm","title":"Double Oracle algorithm","text":"","category":"section"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"This algorithm is more suitable for games with large number of actions, where it is not expected that the support of an equilibrium strategy is not expected to be very large. On such games, it should outperform the standard Linear programming method.","category":"page"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"solve(::NormalFormGame, ::Type{DoubleOracleAlgorithm})","category":"page"},{"location":"solve_do/#DoubleOracle.solve-Tuple{NormalFormGame, Type{Double Oracle algorithm}}","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.solve","text":"solve(nfg::NormalFormGame, ::Type{DoubleOracleAlgorithm})\n\nSolve the NormalFormGame by Oracle algorithm and return the outcome and equilibrium strategies.\n\nAlgorithm\n\nStart from random actions in the Oracles for both players\nRepeat\nSolve a restriction of the game given by the Oracles by Linear programming method\nFind best response pure strategies to the equilibrium strategies from the restricted game\nIf both found pure strategies are already present in the Oracles, end the loop\nAdd best responses to Oracles\nReturn final equilibrium strategies and payoffs\n\n\n\n\n\n","category":"method"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"Note that the double oracle algorithm does not necessarily compute the whole strategy, but only a part corresponding to the restricted payoff matrix. To fix this issue, the following function is used to finalize the output.","category":"page"},{"location":"solve_do/","page":"Solution by Double Oracle algorithm","title":"Solution by Double Oracle algorithm","text":"fullstrategy(::Oracle, ::Vector{Float64}, n::Integer)","category":"page"},{"location":"solve_do/#DoubleOracle.fullstrategy-Tuple{Oracle, Vector{Float64}, Integer}","page":"Solution by Double Oracle algorithm","title":"DoubleOracle.fullstrategy","text":"fullstrategy(O::Oracle, p::Vector{Float64}, n::Integer)\n\nCreates a new strategy of length n. The probabilities of actions in the Oracle O are replaced with values from restricted strategy p (of the length n). Rest of the probabilities are set to 0.0.\n\nExamples\n\njulia> O = Oracle(Player(1), 1);\n\njulia> add!(O, 3);\n\njulia> O\nOracle for Player 1 has actions: [1, 3]\n\njulia> p = [0.3, 0.7];\n\njulia> fullstrategy(O, p, 4)\n4-element Vector{Float64}:\n 0.3\n 0.0\n 0.7\n 0.0\n\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = DoubleOracle","category":"page"},{"location":"#DoubleOracle-package","page":"Home","title":"DoubleOracle package","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for DoubleOracle package contining solution methods for some parts of game theory using exact methods and variations of Oracle methods.","category":"page"},{"location":"#Table-of-contents-for-easy-navigation","page":"Home","title":"Table of contents for easy navigation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"solve_lp/#Exact-solution-by-linear-programming","page":"Exact solution by Linear programming","title":"Exact solution by linear programming","text":"","category":"section"},{"location":"solve_lp/","page":"Exact solution by Linear programming","title":"Exact solution by Linear programming","text":"LinearProgram","category":"page"},{"location":"solve_lp/#DoubleOracle.LinearProgram","page":"Exact solution by Linear programming","title":"DoubleOracle.LinearProgram","text":"LinearProgram\n\nSubtype of Algorithm representing exact solution of a Normal-Form game by linear programming.\n\n\n\n\n\n","category":"type"},{"location":"solve_lp/","page":"Exact solution by Linear programming","title":"Exact solution by Linear programming","text":"To obtain an exact solution of a given Normal-Form game, use the function solve with LinearProgram parameter.","category":"page"},{"location":"solve_lp/","page":"Exact solution by Linear programming","title":"Exact solution by Linear programming","text":"solve(::NormalFormGame, ::Type{LinearProgram})","category":"page"},{"location":"solve_lp/#DoubleOracle.solve-Tuple{NormalFormGame, Type{Linear program}}","page":"Exact solution by Linear programming","title":"DoubleOracle.solve","text":"solve(nfg::NormalFormGame, ::Type{LinearProgram})\n\nSolve the NormalFormGame by linear programming and return the outcome and equilibrium strategies.\n\n\n\n\n\n","category":"method"}]
}
