using AMDGPU
using Documenter

const dst = "https://amdgpu.juliagpu.org/stable/"

function main()
    ci = get(ENV, "CI", "") == "true"

    @info "Generating Documenter site"
    DocMeta.setdocmeta!(AMDGPU, :DocTestSetup, :(using AMDGPU); recursive=true)
    makedocs(;
        modules=[AMDGPU],
        sitename="AMDGPU.jl",
        format=Documenter.HTML(
            # Use clean URLs on CI
            prettyurls = ci,
            canonical = dst,
            assets = ["assets/favicon.ico"],
            analytics = "UA-154489943-2",
        ),
        pages=[
            "Home" => "index.md",
            "Quick Start" => "quickstart.md",
            "Devices" => "devices.md",
            "Streams" => "streams.md",
            "Kernel Programming" => "kernel_programming.md",
            "Exceptions" => "exceptions.md",
            "Profiling" => "profiling.md",
            "Memory" => "memory.md",
            "Host-Call" => "hostcall.md",
            "Printing" => "printing.md",
            "Logging" => "logging.md",
            "API Reference" => "api.md"
        ],
        doctest=true,
        warnonly=[:missing_docs],
    )
    if ci
        @info "Deploying to GitHub"
        deploydocs(;
            repo="github.com/JuliaGPU/AMDGPU.jl.git",
            push_preview=true,
        )
    end
end

isinteractive() || main()
