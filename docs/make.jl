using DoubleOracle
using Documenter

DocMeta.setdocmeta!(DoubleOracle, :DocTestSetup, :(using DoubleOracle); recursive=true)

makedocs(;
    modules=[DoubleOracle],
    authors="Jakub Rada <dev.jakubrada@icloud.com> and contributors",
    repo="https://github.com/radajakub/DoubleOracle.jl/blob/{commit}{path}#{line}",
    sitename="DoubleOracle.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
