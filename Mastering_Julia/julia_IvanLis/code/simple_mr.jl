#
# simple_mr.jl
#
# Реализация простого механизма MapReduce

addprocs(3);

@everywhere using DistributedArrays

d  = drand(300,300);

nd = length(d.pids)   # ранее было length(d.chunks)

µ = reduce(+, map(fetch, 
                  {@spawnat p mean(localpart(d)) for p in procs(d) }))/nd

s = reduce(+, map(fetch, 
                  {@spawnat p std(localpart(d)) for p in procs(d) }))/nd
