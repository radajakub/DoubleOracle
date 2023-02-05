using Pkg
Pkg.activate(pwd())

using BenchmarkTools
using DoubleOracle
using Plots

# generate larger and larger games and compare solution times for both concepts

# set game sizes to test
sizes = vcat(collect(2:2:10), collect(10:10:100))

# lists for support ratios for row and column player for each game size
rowsupports = []
colsupports = []

# lists of times for each algorithm for each game size
lptimes = []
dotimes = []

# lists of memory for each algorithm for each game size
lpmemory = []
domemory = []

# lists of allocs for each algorithm for each game size
lpallocs = []
doallocs = []


for c in sizes
    println("benchmark on U is $c×$c")
    nfg = generate(NormalFormGame; A1min=c, A1max=2c, A2min=c, A2max=2c)

    # measure and store time for linear programming
    lpbench = @benchmark solve($nfg, LinearProgram)
    lp_median = median(lpbench)
    push!(lptimes, lp_median.time)
    push!(lpmemory, lp_median.memory)
    push!(lpallocs, lp_median.allocs)

    # measure and store time for double oracle algorithm
    dobench = @benchmark solve($nfg, DoubleOracleAlgorithm)
    do_median = median(dobench)
    push!(dotimes, do_median.time)
    push!(domemory, do_median.memory)
    push!(doallocs, do_median.allocs)

    # compute solution to analyze strategies
    s = solve(nfg, LinearProgram)
    s1, s2 = supportratio(s)
    push!(rowsupports, s1)
    push!(colsupports, s2)
end

lptimes ./= 1e6
dotimes ./= 1e6

# plot times based on size of game
timeplot = plot(sizes,
    [lptimes dotimes];
    labels=["Linear program" "Double Oracle"],
    shape=:circle,
    minorgrid=true,
    xguide="Size of game (N×N)",
    yguide="Time [ms]"
)
savefig(timeplot, "../docs/pictures/timeplot.png")


lpmemory ./= 2^20
domemory ./= 2^20

# plot memory based on size of game
timeplot = plot(sizes,
    [lpmemory domemory];
    labels=["Linear program" "Double Oracle"],
    shape=:circle,
    minorgrid=true,
    xguide="Size of game (N×N)",
    yguide="Memory [MiB]"
)
savefig(timeplot, "../docs/pictures/memplot.png")

# plot allocations based on size of game
timeplot = plot(sizes,
    [lpallocs doallocs];
    labels=["Linear program" "Double Oracle"],
    shape=:circle,
    minorgrid=true,
    xguide="Size of game (N×N)",
    yguide="Allocations"
)
savefig(timeplot, "../docs/pictures/allocplot.png")

# plot support ratios based on size of game
timeplot = plot(sizes,
    [rowsupports colsupports];
    labels=["Row player (1)" "Column player (2)"],
    shape=:circle,
    minorgrid=true,
    xguide="Size of game (N×N)",
    yguide="Support ratio (|Support| / |A|)"
)
savefig(timeplot, "../docs/pictures/supportplot.png")
