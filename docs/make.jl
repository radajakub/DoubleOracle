using DoubleOracle
using Documenter

DocMeta.setdocmeta!(DoubleOracle, :DocTestSetup, :(using DoubleOracle); recursive=true)

makedocs(;
    modules=[DoubleOracle],
    authors="Jakub Rada <dev.jakubrada@icloud.com>",
    repo="https://github.com/radajakub/DoubleOracle/blob/{commit}{path}#{line}",
    sitename="DoubleOracle Documentation",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="master",
        assets=String[]
    ),
    pages=[
        "Home" => "index.md",
        "Documentation" => [
            "Game definition" => "game.md",
            "Solution utilities" => "solution_utils.md",
            "Exact solution by Linear programming" => "solve_lp.md",
            "Solution by Double Oracle algorithm" => "solve_do.md",
        ],
        "Benchmarks" => "benchmarks.md",
        "Index" => "doc_index.md",
    ]
)
deploydocs(
    repo="github.com/radajakub/DoubleOracle.git",
    branch="pages",
)
