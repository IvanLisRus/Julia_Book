## Copyright (c) 2013 Miguel Bazdresch
##
## This file is distributed under the 2-clause BSD License.
##
## 2016-05: Updated and tested using gnuplot 5.0 patchlevel 3 & Julia 0.4.5 by Andre Logunov

# types and constructors

# We need a global variable to keep track of gnuplot's state
type GnuplotState
    running::Bool               # true when gnuplot is already running
    current::Int                # current figure
    fid                         # pipe stream id
    tmpdir::AbstractString      # where to store data files  #UPD# String -> AbstractString everywhere in the code
    figs::Array                 # storage for all figures

    function GnuplotState(running::Bool,current::Int,fid,tmpdir::AbstractString,
        figs::Array)
        # Check to see if tmpdir exists, and create it if not
        # TODO: there has to be a simpler way to do this
        try
            f = open(tmpdir)
            close(f)
        catch
		    mkdir(tmpdir) #UPD# run(`mkdir $tmpdir`) -> mkdir(tmpdir)
        end
        new(running,current,fid,tmpdir,figs)
    end
end

# Structure to keep Gaston's configuration
type GastonConfig
    # default CurveConf values
    legend::AbstractString
    plotstyle::AbstractString
    color::AbstractString
    marker::AbstractString
    linewidth::Real
    pointsize::Real
    # default AxesConf values
    title::AbstractString
    xlabel::AbstractString
    ylabel::AbstractString
    zlabel::AbstractString
    box::AbstractString
    axis::AbstractString
    # default terminal type
    terminal::AbstractString
    # for terminals that support filenames
    outputfile::AbstractString
    # for printing to file
    print_color::AbstractString
    print_fontface::AbstractString
    print_fontsize::Real
    print_fontscale::Real
    print_linewidth::Real
    print_size::AbstractString
end
GastonConfig() = GastonConfig(
    # CurveConf
    "","lines","","",1,0.5,
    # AxesConf
    "Untitled","x","y","z","inside vertical right top","",
    # terminal
    "wxt",
    # output file name
    "",
    # print parameters
    "color", "Sans", 12, 0.5, 1, "5in,3in"
    )

# Structs to configure a plot
# Two types of configuration are needed: one to configure a single curve, and
# another to configure a set of curves (the 'axes').
type CurveConf
    legend::AbstractString          # legend text
    plotstyle::AbstractString
    color::AbstractString           # one of gnuplot's builtin colors --
                            # run 'show colornames' inside gnuplot
    marker::AbstractString          # point type
    linewidth::Real
    pointsize::Real

end
CurveConf() = CurveConf(
    gaston_config.legend,
    gaston_config.plotstyle,
    gaston_config.color,
    gaston_config.marker,
    gaston_config.linewidth,
    gaston_config.pointsize)

type AxesConf
    title::AbstractString      # plot title
    xlabel::AbstractString     # xlabel
    ylabel::AbstractString     # ylabel
    zlabel::AbstractString     # zlabel for 3-d plots
    box::AbstractString        # legend box (used with 'set key')
    axis::AbstractString       # normal, semilog{x,y}, loglog
end
AxesConf() = AxesConf(
    gaston_config.title,
    gaston_config.xlabel,
    gaston_config.ylabel,
    gaston_config.zlabel,
    gaston_config.box,
    gaston_config.axis)

# coordinates and configuration for a single curve
type CurveData
    x::Vector          # abscissa
    y::Vector          # ordinate
    Z::Array           # 3-d plots and images
    ylow::Vector       # error data
    yhigh::Vector      # error data
    conf::CurveConf    # curve configuration
end
CurveData() = CurveData([],[],[],[],[],CurveConf())
CurveData(x,y,Z,conf::CurveConf) = CurveData(x,y,Z,[],[],conf)

# curves and configuration for a single figure
type Figure
    handle::Int                  # each figure has a unique handle
    curves::Vector{CurveData}    # a vector of curves (x,y,conf)
    conf::AxesConf               # figure configuration
    isempty::Bool                # a flag to indicate if figure is empty
end
Figure(handle) = Figure(handle,[CurveData()],AxesConf(),true)

# coordinate type
Coord = Union{Range,Range,Matrix,Vector}  #UPD#  Union(...) -> Union(...)
