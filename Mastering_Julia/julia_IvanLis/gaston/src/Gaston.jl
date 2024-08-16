## Copyright (c) 2013 Miguel Bazdresch
##
## This file is distributed under the 2-clause BSD License.
##
## 2016-05: Updated and tested using gnuplot 5.0 patchlevel 3 & Julia 0.4.5 by Andre Logunov


#UPD#
##
## USAGE under Windows (8/10):
## - install gnuplot 5.0 (http://www.gnuplot.info/)
## - specify its /bin directory in your System path (C:\Program Files (x86)\gnuplot\bin)
## - !copy Windows/System32/msvcr100.dll to the Julia's ..\Julia-0.4.5\lib\julia folder!
## - place the Gaston source to the Julia homedir() location or below
##
## In console or in Jupyter notebook:
## - cd(joinpath(homedir(),[the_long_way_to],"gaston","src"))
## - include("Gaston.jl")
## - using Gaston
##
#eof UPD#


module Gaston

export closefigure, closeall, clearfigure, figure, plot, histogram, imagesc,
    surf, printfigure, gaston_demo, gaston_tests, set_terminal, set_filename,
    set_default_legend, set_default_plotstyle, set_default_color,
    set_default_marker, set_default_linewidth, set_default_pointsize,
    set_default_title, set_default_xlabel, set_default_ylabel,
    set_default_zlabel, set_default_box, set_default_axis, set_print_color,
    set_print_fontface, set_print_fontsize, set_print_fontscale,
    set_print_linewidth, set_print_size, gnuplot_send

# before doing anything else, verify gnuplot is present on this system

#UPD#
#if !success(`which gnuplot`)
#    error("Gaston cannot be loaded: gnuplot is not available on this system.")
#end
#if readchomp(`gnuplot --version`)[1:11] != "gnuplot 4.6"
#    println("Warning: Gaston has only been tested on gnuplot version 4.6")
#end
#eof UPD#


# load files

#UPD#
@windows ? Libdl.dlopen("msvcr100") : ()    # this .dll must be in Julia's /lib/julia folder
#eof UPD#

include("gaston_types.jl")
include("gaston_aux.jl")
include("gaston_lowlvl.jl")
include("gaston_midlvl.jl")
include("gaston_hilvl.jl")
include("gaston_config.jl")
include("gaston_demo.jl")
include("gaston_test.jl")

# set up global variables
# global variable that stores gnuplot's state

gnuplot_state = Union{}  #UPD# None -> Union{}

#UPD#
function get_linux_gps()
    GnuplotState(false,0,0,string("/tmp/gaston-",ENV["USER"], "-",randstring(5),"/"),[])
end
function get_windows_gps()
    # Store temporary files in gaston/tmp folder
    # Change this path according to your Julia installation path!!!
    tmpdir = joinpath(homedir(),"julia_projects","gaston","tmp",randstring(5))  
    #run(`Get-ChildItem -Path $tmpdir -Include *.* -File | foreach { $_.Delete()}`)
    #rm(tmpdir, true)  

    #GnuplotState(false,0,0,string(replace(ENV["TMP"],"\\","/"),"/gaston-",ENV["USERNAME"],"-",randstring(5)),[])
    GnuplotState(false,0,0,tmpdir,[]) 
end	
gnuplot_state = @linux ? get_linux_gps() : get_windows_gps()
#eof UPD#

# when gnuplot_state goes out of scope, close the pipe
finalizer(gnuplot_state,gnuplot_exit)

# global variable that stores Gaston's configuration
gaston_config = GastonConfig()

end

