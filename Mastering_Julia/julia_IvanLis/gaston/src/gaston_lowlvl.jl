## Copyright (c) 2013 Miguel Bazdresch
##
## This file is distributed under the 2-clause BSD License.
##
## 2016-05: Updated and tested using gnuplot 5.0 patchlevel 3 & Julia 0.4.5 by Andre Logunov

# write commands to gnuplot's pipe
function gnuplot_send(s::AbstractString)
    fid = gnuplot_state.fid
	
	#UPD#
	err = @linux ? ccall(:fputs, Int, (Ptr{UInt8},Ptr{Int}), string(s,"\n"), fid) : ccall((:fputs,"msvcr100"), Int, (Ptr{UInt8},Ptr{Int}), string(s,"\n"), fid)  #windows
	#eof UPD#
	
    # fputs returns a positive number if everything worked all right
    if err < 0
        println("Something went wrong writing to the gnuplot pipe.")
        return
    end
	
	#UPD#
	err = @linux ? ccall(:fflush, Int, (Ptr{Int},), fid) : ccall((:fflush,"msvcr100"), Int, (Ptr{Int},), fid)  #windows
	#eof UPD#
	
    ## fflush returns 0 if everything worked all right
    if err != 0
        println("Something went wrong writing to the gnuplot pipe.")
        return
    end
end
